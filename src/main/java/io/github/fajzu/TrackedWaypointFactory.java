package io.github.fajzu;

import com.github.retrooper.packetevents.protocol.color.Color;
import com.github.retrooper.packetevents.protocol.world.waypoint.TrackedWaypoint;
import com.github.retrooper.packetevents.protocol.world.waypoint.Vec3iWaypointInfo;
import com.github.retrooper.packetevents.protocol.world.waypoint.WaypointIcon;
import com.github.retrooper.packetevents.protocol.world.waypoint.WaypointInfo;
import com.github.retrooper.packetevents.util.Either;
import com.github.retrooper.packetevents.util.Vector3i;

public class TrackedWaypointFactory {

    public TrackedWaypoint create(final Waypoint waypoint) {
        final WaypointIcon icon = new WaypointIcon(
                WaypointStyle.resolve(waypoint),

                new Color(waypoint.color().getRed(), waypoint.color().getGreen(), waypoint.color().getBlue())
        );

        final WaypointInfo info = new Vec3iWaypointInfo(
                new Vector3i(
                        waypoint.position().blockX(),
                        waypoint.position().blockY(),
                        waypoint.position().blockZ()
                )
        );

        return new TrackedWaypoint(
                Either.createLeft(waypoint.uuid()),
                icon,
                info
        );
    }
}