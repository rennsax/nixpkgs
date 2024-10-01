xmakeConfigurePhase() {
    runHook preConfigure

    local flagsArray=()
    concatTo flagsArray xmakeFlags xmakeFlagsArray

    echoCmd 'xmake config flags' "${flagsArray[@]}"

    xmake config "${flagsArray[@]}"
    unset flagsArray

    if ! [[ -v enableParallelBuilding ]]; then
        enableParallelBuilding=1
        echo "xmake: enabled parallel building"
    fi

    runHook postConfigure
}

xmakeBuildPhase() {
    runHook preBuild

    local flagsArray=(
        ${enableParallelBuilding:+-j${NIX_BUILD_CORES}}
    )

    concatTo flagsArray xmakeFlags xmakeFlagsArray buildFlags buildFlagsArray

    echoCmd 'xmake build flags' "${flagsArray[@]}"
    xmake build "${flagsArray[@]}"
    unset flagsArray

    runHook postBuild
}

xmakeInstallPhase() {
    runHook preInstall

    local flagsArray=(
        "-o $out"
    )

    concatTo flagsArray xmakeFlags xmakeFlagsArray installFlags installFlagsArray

    echoCmd 'xmake install flags' "${flagsArray[@]}"
    xmake install "${flagsArray[@]}"
    unset flagsArray

    runHook postInstall
}

if [ -z "${dontUseXmake-}" ]; then
    configurePhase=xmakeConfigurePhase
    buildPhase=xmakeBuildPhase
    installPhase=xmakeInstallPhase
fi
