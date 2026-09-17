workspaces=$(hyprctl workspaces | grep -Eo 'workspace ID [0-9]' | awk '{print $3}')

activeworkspace=$(hyprctl activeworkspace | grep -Eo 'workspace ID [0-9]' | awk '{print $3}') 

for i in $workspaces; do 
    if [[ $i -eq $activeworkspace ]]; then
        echo "Workspace $i is Active"
    else
        echo "Workspace $i is Inactive"
    fi
done
