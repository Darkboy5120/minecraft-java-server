# Minecraft Server Docker Setup

This repository contains a Docker setup for running a Minecraft server with customizable configuration through environment variables.

## Quick Start

1. **Clone this repository** (if not already done)

2. **Customize your server settings** by editing the `.env` file:
   ```bash
   cp .env .env.local  # Optional: create a local copy
   # Edit .env or .env.local with your preferred settings
   ```

3. **Start the server**:
   ```bash
   docker-compose up -d
   ```

4. **Check server logs**:
   ```bash
   docker-compose logs -f minecraft
   ```

5. **Stop the server**:
   ```bash
   docker-compose down
   ```

## Configuration Options

### Basic Settings
- `VERSION`: Minecraft version (e.g., "1.20.1", "LATEST", "SNAPSHOT")
- `TYPE`: Server type (VANILLA, FORGE, FABRIC, PAPER, SPIGOT, etc.)
- `SERVER_NAME`: Server name for display
- `MOTD`: Message of the day shown in server list

### Network Settings
- `SERVER_PORT`: Port for Minecraft connections (default: 25565)
- `RCON_PORT`: Port for RCON remote console (default: 25575)
- `RCON_PASSWORD`: Password for RCON access
- `ENABLE_RCON`: Enable/disable RCON (true/false)

### Game Settings
- `DIFFICULTY`: Game difficulty (peaceful, easy, normal, hard)
- `GAMEMODE`: Default game mode (survival, creative, adventure, spectator)
- `MAX_PLAYERS`: Maximum number of players
- `VIEW_DISTANCE`: Server view distance in chunks
- `PVP`: Enable/disable player vs player combat
- `ALLOW_FLIGHT`: Allow flying in survival mode

### World Settings
- `LEVEL_NAME`: World/level name
- `LEVEL_TYPE`: World type (default, flat, amplified, etc.)
- `SEED`: World generation seed (leave empty for random)
- `GENERATE_STRUCTURES`: Generate structures like villages

### Security Settings
- `ONLINE_MODE`: Verify player accounts with Mojang (recommended: true)
- `ENABLE_WHITELIST`: Enable whitelist (true/false)
- `WHITELIST`: Comma-separated list of allowed usernames
- `OPS`: Comma-separated list of operator usernames

### Performance Settings
- `MEMORY`: RAM allocation (e.g., "1G", "2G", "4G")
- `JVM_OPTS`: Java Virtual Machine optimization flags

## Advanced Usage

### Using with Different Server Types

To use Paper server instead of Vanilla:
```env
TYPE=PAPER
VERSION=1.20.1
```

To use Forge with mods:
```env
TYPE=FORGE
VERSION=1.20.1
```

### Custom JVM Options

For better performance, you can customize JVM options:
```env
JVM_OPTS=-Xms2G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled
```

### Whitelist Setup

1. Enable whitelist:
   ```env
   ENABLE_WHITELIST=true
   WHITELIST=player1,player2,player3
   ```

2. Or manage whitelist through RCON:
   ```bash
   docker exec -i minecraft-server rcon-cli whitelist add <username>
   ```

### Server Management Commands

Connect to server console:
```bash
docker exec -it minecraft-server rcon-cli
```

View server properties:
```bash
docker exec minecraft-server cat /data/server.properties
```

Backup world data:
```bash
docker run --rm -v minecraft_data:/data -v $(pwd)/backup:/backup alpine tar czf /backup/world-backup-$(date +%Y%m%d).tar.gz -C /data world
```

Restore world data:
```bash
docker run --rm -v minecraft_data:/data -v $(pwd)/backup:/backup alpine tar xzf /backup/world-backup-YYYYMMDD.tar.gz -C /data
```

## Troubleshooting

### Server won't start
- Check if EULA is set to TRUE in .env
- Ensure ports are not already in use
- Check Docker logs: `docker-compose logs minecraft`

### Performance Issues
- Increase MEMORY allocation
- Reduce VIEW_DISTANCE and SIMULATION_DISTANCE
- Optimize JVM_OPTS for your system

### Connection Issues
- Verify SERVER_PORT is correctly mapped
- Check Windows Firewall settings
- Ensure Docker Desktop is running

## File Structure

```
minecraft-server/
├── Dockerfile              # Docker image definition
├── docker-compose.yml      # Docker Compose configuration
├── .env                    # Environment variables (customize this)
└── README.md              # This file
```

## Data Persistence

Server data is stored in a Docker volume named `minecraft_data`. This includes:
- World files
- Server configuration
- Player data
- Plugins/mods (if applicable)

The data persists even when the container is recreated.