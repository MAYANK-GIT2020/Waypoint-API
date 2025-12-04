package io.github.fajzu;

import org.bukkit.Color;
import org.bukkit.Location;

import java.util.UUID;

public record Waypoint(UUID uuid,
                       String name,
                       Location location,
                       Color color,
                       WaypointStyle style) {

    public WaypointBuilder toBuilder() {
        return WaypointBuilder.builder(this);
    }
}
