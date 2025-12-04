package io.github.fajzu;

import java.util.List;

class WaypointConstants {

    public static final List<String> DEPENDENCY_NOT_FOUND = List.of(
            "Initialization failed due to the following issues:",
            "",
            "- PacketEvents is not installed or not enabled!",
            "  Please install PacketEvents to use Waypoint-API.",
            "",
            "Waypoint cannot be enabled until these issues are resolved."
    );


    public static final List<String> OLD_VERSION = List.of(
            "Initialization failed due to the following issues:",
            "",
            "- Unsupported server version: Your current version is too old.",
            "  Minimum supported: 1.21.6+.",
            "",
            "Waypoint cannot be enabled until these issues are resolved."
    );

    private WaypointConstants() {
    }

}
