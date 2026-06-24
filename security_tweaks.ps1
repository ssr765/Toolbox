# Change execution policy to something usable.
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Use reasonable npm config, if installed.
if (Get-Command npm -ErrorAction SilentlyContinue) {
    npm config set ignore-scripts true --global
    npm config set min-release-age 3 --global
}