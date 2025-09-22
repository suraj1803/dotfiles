package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"strconv"
	"strings"
	"sync"
)

type Container struct {
	Name   string `json:"name"`
	Status string `json:"status"`
	ID     string `json:"id"`
}

type RunningContainer struct {
	Name  string `json:"name"`
	Used  string `json:"used"`
	Limit string `json:"limit"`
}

type WaybarOutput struct {
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
	Class   string `json:"class"`
	Alt     string `json:"alt"`
}

func getContainers() []Container {
	cmd := exec.Command("docker", "ps", "-a", "--format", "{{.Names}}|{{.Status}}|{{.ID}}")
	output, err := cmd.Output()
	if err != nil {
		return []Container{}
	}

	lines := strings.Split(strings.TrimSpace(string(output)), "\n")
	if len(lines) == 1 && lines[0] == "" {
		return []Container{}
	}

	var containers []Container
	for _, line := range lines {
		if line == "" {
			continue
		}
		parts := strings.Split(line, "|")
		if len(parts) != 3 {
			continue
		}

		status := "Stopped"
		if strings.HasPrefix(parts[1], "Up") {
			status = "Running"
		}

		containers = append(containers, Container{
			Name:   parts[0],
			Status: status,
			ID:     parts[2],
		})
	}

	return containers
}

func convertToBytes(sizeStr string) int64 {
	units := map[string]int64{
		"B":   1,
		"KiB": 1024,
		"MiB": 1024 * 1024,
		"GiB": 1024 * 1024 * 1024,
		"TiB": 1024 * 1024 * 1024 * 1024,
	}

	if sizeStr == "" || sizeStr == "N/A" {
		return 0
	}

	re := regexp.MustCompile(`([\d\.]+)([A-Za-z]+)`)
	matches := re.FindStringSubmatch(sizeStr)
	if len(matches) != 3 {
		return 0
	}

	value, err := strconv.ParseFloat(matches[1], 64)
	if err != nil {
		return 0
	}

	unit := matches[2]
	if multiplier, exists := units[unit]; exists {
		return int64(value * float64(multiplier))
	}

	return 0
}

func formatMemory(bytes int64) string {
	const unit = 1024
	if bytes < unit {
		return fmt.Sprintf("%d B", bytes)
	}

	div, exp := int64(unit), 0
	for n := bytes / unit; n >= unit; n /= unit {
		div *= unit
		exp++
	}

	units := []string{"KiB", "MiB", "GiB", "TiB"}
	return fmt.Sprintf("%.1f %s", float64(bytes)/float64(div), units[exp])
}

func getRunningContainerStats(containers []Container) ([]RunningContainer, int64) {
	var runningContainers []RunningContainer
	var totalMemoryBytes int64
	var wg sync.WaitGroup
	var mu sync.Mutex

	for _, container := range containers {
		if container.Status == "Running" {
			wg.Add(1)
			go func(container Container) {
				defer wg.Done()
				cmd := exec.Command("docker", "stats", container.ID, "--no-stream", "--format", "{{.MemUsage}}")
				output, err := cmd.Output()
				if err != nil {
					return
				}

				memStats := strings.TrimSpace(string(output))
				memParts := strings.Split(memStats, " / ")

				usedStr := memParts[0]
				limitStr := "N/A"
				if len(memParts) > 1 {
					limitStr = memParts[1]
				}

				usedBytes := convertToBytes(usedStr)

				mu.Lock()
				totalMemoryBytes += usedBytes
				runningContainers = append(runningContainers, RunningContainer{
					Name:  container.Name,
					Used:  usedStr,
					Limit: limitStr,
				})
				mu.Unlock()
			}(container)
		}
	}

	wg.Wait()
	return runningContainers, totalMemoryBytes
}

func main() {

	allContainers := getContainers()
	runningContainers, totalMemoryBytes := getRunningContainerStats(allContainers)

	memDisplay := formatMemory(totalMemoryBytes)

	var tooltipBuilder strings.Builder

	for _, container := range allContainers {
		memoryInfo := ""
		for _, running := range runningContainers {
			if running.Name == container.Name {
				memoryInfo = fmt.Sprintf(" - %s/%s", running.Used, running.Limit)
				break
			}
		}

		tooltipBuilder.WriteString(fmt.Sprintf("%s [%s]%s\n", container.Name, container.Status, memoryInfo))
	}

	tooltip := strings.TrimSpace(tooltipBuilder.String())

	output := WaybarOutput{
		Text:    fmt.Sprintf("󰡨 %s", memDisplay),
		Tooltip: tooltip,
		Class:   "docker",
		Alt:     fmt.Sprintf("Docker (%d/%d)", len(runningContainers), len(allContainers)),
	}

	if len(allContainers) == 0 {
		output = WaybarOutput{
			Text:    "󰡨 N/A",
			Tooltip: "No Docker containers found",
			Class:   "docker-none",
			Alt:     "Docker (0/0)",
		}
	}

	jsonOutput, err := json.Marshal(output)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error creating JSON: %v\n", err)
		return
	}

	fmt.Println(string(jsonOutput))
}
