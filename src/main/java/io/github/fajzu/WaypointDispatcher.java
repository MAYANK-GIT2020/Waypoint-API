package io.github.fajzu;

import com.github.retrooper.packetevents.PacketEvents;
import com.github.retrooper.packetevents.manager.player.PlayerManager;
import com.github.retrooper.packetevents.protocol.world.waypoint.TrackedWaypoint;
import com.github.retrooper.packetevents.wrapper.play.server.WrapperPlayServerWaypoint;
import org.bukkit.entity.Player;

public class WaypointDispatcher {

    private final TrackedWaypointFactory trackedWaypointFactory;

    private final PlayerManager playerManager;

    public WaypointDispatcher(TrackedWaypointFactory trackedWaypointFactory) {
        this.trackedWaypointFactory = trackedWaypointFactory;

        this.playerManager = PacketEvents.getAPI().getPlayerManager();
    }

    public void send(final Player player,
                     final Waypoint waypoint,
                     final WaypointOperation operation) {
        final TrackedWaypoint trackedWaypoint = trackedWaypointFactory.create(waypoint);

        final WrapperPlayServerWaypoint packet = new WrapperPlayServerWaypoint(operation.operation(), trackedWaypoint);

        this.playerManager.sendPacket(player, packet);
    }

    public void track(final Player player,
                      final Waypoint waypoint) {
        this.send(player, waypoint, WaypointOperation.TRACK);
    }

    public void hide(final Player player,
                     final Waypoint waypoint) {
        this.send(player, waypoint, WaypointOperation.HIDE);
    }

    public void update(final Player player,
                       final Waypoint waypoint) {
        this.send(player, waypoint, WaypointOperation.UPDATE);
    }

}
