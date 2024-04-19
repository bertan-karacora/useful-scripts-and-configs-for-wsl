if [ -d ~/useful-scripts-and-configs-for-wsl/libs ]; then
    for lib in ~/useful-scripts-and-configs-for-wsl/libs/*; do
        if [ -f "$lib" ]; then
            . "$lib"
        fi
    done
fi
