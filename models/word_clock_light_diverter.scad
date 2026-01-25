// Word Clock Light Diverter (Baffle) - Hollow Border Version
// Based on word_clock_stencil.scad dimensions

// --- Dimensions from Stencil Source ---
width = 175;           // [cite: 1]
height = 130;          // [cite: 2]
border_lr = 50;        // left & right 
border_tb = 20;        // top & bottom 
cols = 11;             // [cite: 5]
rows = 10;             // [cite: 5]

// --- Baffle Settings ---
baffle_height = 15;    // Total depth of the diverter
wall_thickness = 1.2;  // Thickness of internal grid walls
edge_thickness = 2.0;  // Thickness of the outermost perimeter edge

// --- Calculated Values ---
outer_width  = width  + border_lr * 2; // 
outer_height = height + border_tb * 2; // 
cell_w = width / cols;                 // [cite: 5]
cell_h = height / rows;                // [cite: 5]

union() {
    // 1. Outer Perimeter Edge (The Frame)
    difference() {
        cube([outer_width, outer_height, baffle_height]);
        translate([edge_thickness, edge_thickness, -1])
            cube([outer_width - (edge_thickness * 2), outer_height - (edge_thickness * 2), baffle_height + 2]);
    }

    // 2. Internal Grid (Aligned to Stencil Letters)
    // Offset by border values to center the grid 
    translate([border_lr, border_tb, 0]) {
        // Vertical Internal Walls
        for (i = [0 : cols]) {
            translate([i * cell_w - wall_thickness / 2, 0, 0])
                cube([wall_thickness, height, baffle_height]);
        }

        // Horizontal Internal Walls
        for (j = [0 : rows]) {
            translate([0, j * cell_h - wall_thickness / 2, 0])
                cube([width, wall_thickness, baffle_height]);
        }
    }
}