// Word Clock Light Diverter (Baffle)
// Matches word_clock_stencil.scad dimensions

// Inner grid dimensions [cite: 1, 2]
width = 175;
height = 130;

// Grid layout 
cols = 11;
rows = 10;

// Border offsets [cite: 3]
border_lr = 50; // left & right
border_tb = 20; // top & bottom

// Baffle Specific Settings
baffle_height = 15;    // Depth of the light chambers
wall_thickness = 1.2;  // Thickness of the internal walls
base_thickness = 1.0;  // Thickness of the back plate (set to 0 if not needed)

// Calculated cell sizes [cite: 5]
cell_w = width / cols;
cell_h = height / rows;

// Outer dimensions [cite: 4]
outer_width  = width  + border_lr * 2;
outer_height = height + border_tb * 2;

union() {
    // 1. Base Plate (Optional: connects all baffles together)
    if (base_thickness > 0) {
        cube([outer_width, outer_height, base_thickness]);
    }

    // 2. Outer Border Walls
    difference() {
        cube([outer_width, outer_height, baffle_height]);
        translate([border_lr, border_tb, -1])
            cube([width, height, baffle_height + 2]);
    }

    // 3. Vertical Internal Walls
    for (i = [0 : cols]) {
        translate([border_lr + i * cell_w - wall_thickness / 2, border_tb, 0])
            cube([wall_thickness, height, baffle_height]);
    }

    // 4. Horizontal Internal Walls
    for (j = [0 : rows]) {
        translate([border_lr, border_tb + j * cell_h - wall_thickness / 2, 0])
            cube([width, wall_thickness, baffle_height]);
    }
}