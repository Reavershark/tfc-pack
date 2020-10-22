#!/usr/bin/env bash

mkdir build

DisablePortals/gradlew build -p DisablePortals
cp DisablePortals/build/libs/DisablePortals-1.0.jar build/

ImmersiveEngineering/gradlew build -p ImmersiveEngineering
cp ImmersiveEngineering/build/libs/ImmersiveEngineering-0.12-98-tfccompat.jar build/

VERSION=1.7.3.161-patched TerraFirmaCraft/gradlew build -p TerraFirmaCraft
cp TerraFirmaCraft/build/libs/TerraFirmaCraft-MC1.12.2-1.7.3.161-patched.jar build/

WearableBackpacks/gradlew build -p WearableBackpacks
cp WearableBackpacks/build/libs/WearableBackpacks-1.12.2-3.1.4-tfccompat.jar build/
