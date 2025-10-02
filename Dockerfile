# Minecraft Server Dockerfile
FROM itzg/minecraft-server:latest

# Set the working directory
WORKDIR /data

# Environment variables for server configuration
# Basic server settings
ENV EULA=TRUE
ENV TYPE=VANILLA
ENV VERSION=LATEST
ENV SERVER_NAME="My Minecraft Server"
ENV MOTD="Welcome to my Minecraft server!"

# Server network settings
ENV SERVER_PORT=25565
ENV RCON_PORT=25575
ENV RCON_PASSWORD=""
ENV ENABLE_RCON=false

# Server properties
ENV DIFFICULTY=easy
ENV GAMEMODE=survival
ENV MAX_PLAYERS=20
ENV VIEW_DISTANCE=10
ENV SIMULATION_DISTANCE=10
ENV ALLOW_NETHER=true
ENV ALLOW_FLIGHT=false
ENV PVP=true

# World generation settings
ENV LEVEL_NAME=world
ENV LEVEL_TYPE=default
ENV SEED=""
ENV GENERATE_STRUCTURES=true
ENV SPAWN_PROTECTION=16

# Authentication and security
ENV ONLINE_MODE=true
ENV ENABLE_WHITELIST=false
ENV WHITELIST=""
ENV OPS=""
ENV ENFORCE_WHITELIST=false

# Performance settings
ENV MEMORY=1G
ENV CPU_LIMIT=2.0
ENV JVM_OPTS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1"

# Backup settings
ENV ENABLE_AUTOPAUSE=false
ENV MAX_TICK_TIME=60000

# Logging
ENV ENABLE_ROLLING_LOGS=true

# Expose the default Minecraft port and RCON port
EXPOSE ${SERVER_PORT}
EXPOSE ${RCON_PORT}

# Health check to ensure the server is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD mc-health

# The base image already has the correct entrypoint
# No need to override CMD or ENTRYPOINT