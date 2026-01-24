// ==========================================
// Word Clock Snap-Fit Frame Generator
// ==========================================

// --- 1. DIMENSIONS (Must match your Diverter) ---
total_width = 175;    // Matching diverter width
total_height = 130;   // Matching diverter height
diverter_depth = 10;  // Thickness of the diverter plate

// --- 2. SNAP FIT SETTINGS ---
wall_thickness = 2.0; // Outer wall of the frame
frame_lip = 1.5;      // How much the frame overlaps the diverter
clearance = 0.2;      // Print tolerance (increase if too tight)
snap_height = 2.0;    // Height of the "locking" tab

// ==========================================
// FRAME RENDER LOGIC
// ==========================================

module snap_frame() {
    // Inner dimensions with clearance
    inner_w = total_width + (clearance * 2);
    inner_h = total_height + (clearance * 2);
    
    // Outer dimensions
    outer_w = inner_w + (wall_thickness * 2);
    outer_h = inner_h + (wall_thickness * 2);
    
    difference() {
        // Main Frame Body
        cube([outer_w, outer_h, diverter_depth + snap_height]);

        // Subtract the cavity for the diverter
        translate([wall_thickness, wall_thickness, -1])
            cube([inner_w, inner_h, diverter_depth + 1]);

        // Subtract the "View Window" (hollow center)
        // This leaves the 'lip' that holds the faceplate/diverter
        translate([wall_thickness + frame_lip, wall_thickness + frame_lip, -2])
            cube([inner_w - (frame_lip * 2), inner_h - (frame_lip * 2), diverter_depth + snap_height + 4]);
    }
    
    // Add Snap-Fit Tabs
    // These are small wedges on the inside of the frame walls
    tab_size = 10;
    
    // Position tabs on all four sides
    // Bottom side
    translate([outer_w/2 - tab_size/2, wall_thickness, diverter_depth])
        snap_tab(tab_size);
    
    // Top side
    translate([outer_w/2 + tab_size/2, outer_h - wall_thickness, diverter_depth])
        rotate([0,0,180]) snap_tab(tab_size);
        
    // Left side
    translate([wall_thickness, outer_h/2 + tab_size/2, diverter_depth])
        rotate([0,0,270]) snap_tab(tab_size);
        
    // Right side
    translate([outer_w - wall_thickness, outer_h/2 - tab_size/2, diverter_depth])
        rotate([0,0,90]) snap_tab(tab_size);
}

module snap_tab(w) {
    // A small triangular prism that slopes inward to lock the plate
    rotate([90, 0, 90])
    linear_extrude(height = w)
    polygon(points=[[0,0], [frame_lip * 0.8, 0], [0, snap_height]]);
}

// Render
snap_frame();

// ==========================================
// PRINTING TIPS:
// 1. Print this with the "lip" facing down on the bed.
// 2. Use a material with slight flex like PETG for best snap results. 
// 3. If using PLA, the tabs may be stiff; adjust 'clearance' if needed.