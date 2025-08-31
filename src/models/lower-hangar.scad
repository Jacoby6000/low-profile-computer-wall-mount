use <Round-Anything/polyround.scad>

HANGER_THICKNESS = 5;
HANGER_DEPTH = 20;
HANGER_WIDTH = 40;
HANGER_WALL_MOUNT_HEIGHT = 30;
HANGER_PLATFORM_LENGTH = 20;

SCREW_HOLE_DIAMETER = 2.5;
SCREW_HOLE_DEPTH = HANGER_THICKNESS + 1; 
SCREW_HEAD_RECESS_DIAMETER = 5;
SCREW_HEAD_RECESS_DEPTH = 2;

SCREW_HOLE_TOP_BOTTOM_EDGE_MARGIN = 4;
SCREW_HOLE_LEFT_RIGHT_EDGE_MARGIN = 4;

// L shaped profile
function hangerProfile() = [
    [0, 0, 0],
    [0, HANGER_WALL_MOUNT_HEIGHT, 0],
    [HANGER_THICKNESS, HANGER_WALL_MOUNT_HEIGHT, 0],
    [HANGER_THICKNESS, HANGER_THICKNESS, 5],
    [HANGER_PLATFORM_LENGTH, HANGER_THICKNESS, 0],
    [HANGER_PLATFORM_LENGTH, 0, 0]
];

module hangerBody() {
    linear_extrude(HANGER_DEPTH) polygon(polyRound(hangerProfile()));
}

module screwHoleShape() {
    union() {
        cylinder(h = SCREW_HOLE_DEPTH, d = SCREW_HOLE_DIAMETER, center = true, $fn = 32);
        translate([0, 0, -SCREW_HOLE_DEPTH/2 + SCREW_HEAD_RECESS_DEPTH/2])
            cylinder(h = SCREW_HEAD_RECESS_DEPTH, d = SCREW_HEAD_RECESS_DIAMETER, center = true, $fn = 32);
    }
}

difference() {
    hangerBody();
    translate([HANGER_THICKNESS/2, HANGER_WALL_MOUNT_HEIGHT - SCREW_HOLE_TOP_BOTTOM_EDGE_MARGIN, HANGER_DEPTH - SCREW_HOLE_LEFT_RIGHT_EDGE_MARGIN])
        rotate([0, 270, 0]) 
            screwHoleShape();
    translate([HANGER_THICKNESS/2, HANGER_WALL_MOUNT_HEIGHT - SCREW_HOLE_TOP_BOTTOM_EDGE_MARGIN*3, HANGER_DEPTH - SCREW_HOLE_LEFT_RIGHT_EDGE_MARGIN])
        rotate([0, 270, 0]) 
            screwHoleShape();
    translate([HANGER_THICKNESS/2, HANGER_WALL_MOUNT_HEIGHT - SCREW_HOLE_TOP_BOTTOM_EDGE_MARGIN, SCREW_HOLE_LEFT_RIGHT_EDGE_MARGIN])
        rotate([0, 270, 0]) 
            screwHoleShape();
    translate([HANGER_THICKNESS/2, HANGER_WALL_MOUNT_HEIGHT - SCREW_HOLE_TOP_BOTTOM_EDGE_MARGIN*3, SCREW_HOLE_LEFT_RIGHT_EDGE_MARGIN])
        rotate([0, 270, 0]) 
            screwHoleShape();
}

