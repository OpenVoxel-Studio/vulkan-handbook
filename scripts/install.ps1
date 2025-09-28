# Constantes
$REPO_PATH = $(Split-Path -Parent $(Split-Path -Parent $MyInvocation.MyCommand.Definition))
$DEPS = @(
    "Git.Git",
    "Microsoft.VisualStudioCode",
    "Microsoft.VisualStudio.2022.BuildTools",
    "KhronosGroup.VulkanSDK",
    "BaldurKarlsson.RenderDoc",
    # TODO: Add RenderDoc
)

# Function Declarations
function Build-CmakeFormat {
    docker build -f $REPO_PATH\docker\cmake-format.Dockerfile . -t cmake-format:latest
}

function Install-MicrosoftBuildTools {
        winget install Microsoft.VisualStudio.2022.BuildTools `
            --force --override "--wait --passive --config $REPO_PATH/configs/.vsconfig"
}

# TODO: add support to create a VCPKG_ROOT var env

# Main part
foreach ($Dep in $DEPS) {
    Write-Host "Installing $Dep..."
    if ($Dep -like "*BuildTools") {
        Install-MicrosoftBuildTools
    }
    else {
        winget install $Dep
    }
}