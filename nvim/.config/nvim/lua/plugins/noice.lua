return {
	"folke/noice.nvim",
	opts = function(_, opts)
		opts.routes = opts.routes or {} -- Ensure opts.routes is initialized

		table.insert(opts.routes, {
			filter = {
				event = "notify",
				find = "No information available",
			},
			opts = { skip = true },
		})

		local focused = true
		vim.api.nvim_create_autocmd("FocusGained", {
			callback = function()
				focused = true
			end,
		})
		vim.api.nvim_create_autocmd("FocusLost", {
			callback = function()
				focused = false
			end,
		})

		table.insert(opts.routes, 1, {
			filter = {
				cond = function()
					return not focused
				end,
			},
			view = "notify_send",
			opts = { stop = false },
		})

		opts.commands = {
			all = {
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {},
			},
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function(event)
				vim.schedule(function()
					require("noice.text.markdown").keys(event.buf)
				end)
			end,
		})

		-- Ensure presets exists before modifying it
		opts.presets = opts.presets or {}
		opts.presets.lsp_doc_border = true
	end,
}
