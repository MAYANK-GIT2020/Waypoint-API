package io.github.fajzu;

import com.github.retrooper.packetevents.wrapper.play.server.WrapperPlayServerWaypoint;

enum WaypointOperation {

    TRACK(WrapperPlayServerWaypoint.Operation.TRACK),
    HIDE(WrapperPlayServerWaypoint.Operation.UNTRACK),
    UPDATE(WrapperPlayServerWaypoint.Operation.UPDATE);

    private final WrapperPlayServerWaypoint.Operation operation;

    WaypointOperation(WrapperPlayServerWaypoint.Operation operation) {
        this.operation = operation;
    }

    public WrapperPlayServerWaypoint.Operation operation() {
        return this.operation;
    }
}
