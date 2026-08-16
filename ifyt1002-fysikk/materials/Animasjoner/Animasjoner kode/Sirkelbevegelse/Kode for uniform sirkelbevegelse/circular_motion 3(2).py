"""
This script visualizes uniform circular motion using an interactive matplotlib plot.
It demonstrates the relationships between radius (r), speed (v), angular velocity (ω), and centripetal acceleration (a_c) for an object moving in a circle.

The visualization includes:
- A circle representing the path of motion.
- A point moving along the circle representing the object.
- Vectors for radius (r), velocity (v, tangent to the circle), and centripetal acceleration (a_c, directed inward).
- Interactive sliders to adjust:
  - Radius (r): the radius of the circular path.
  - Speed (v): the linear speed of the object.
  - Initial angle (θ₀): the starting angular position of the object in radians.
- Check buttons to toggle the visibility of the vectors r, v, and a_c.
- Radio buttons to choose which quantity to keep constant when adjusting the radius:
  - "Constant v": speed remains constant, centripetal acceleration changes accordingly.
  - "Constant a_c": centripetal acceleration remains constant, speed adjusts accordingly.
- A pause/play button to start or stop the animation.
- A feedback text area that provides real-time information on how speed (v), angular velocity (ω), and centripetal acceleration (a_c) have changed since the last frame.

This tool is useful for understanding uniform circular motion dynamics and the interplay between these physical quantities.
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
from matplotlib.animation import FuncAnimation
from matplotlib.widgets import Slider, Button

DT = 0.02  # Time step for animation updates
R_MIN, R_MAX = 0.5, 5.0  # Radius slider limits
V_MIN, V_MAX = 0.0, 6.0  # Speed slider limits
K_V, K_A = 0.35, 0.5     # Scaling factors for velocity and acceleration vectors for visualization
PAD_FRAC, PAD_ABS = 0.35, 0.75  # Padding fractions for viewport limits

# Initial values for radius, speed, angular velocity, and initial angle
r0, v0 = 3.0, 2.0
w0 = v0 / r0
theta0 = 0.0

# State dictionary to keep track of animation parameters and control flags
state = {
    "t": 0.0,            # Current time
    "paused": False,     # Animation paused flag
    "updating": False,   # Flag to prevent recursive slider updates
    "control": "v",      # Control mode (not used explicitly here)
    "lim": 6.0,          # Plot axis limit
    "lock": "Constant v",# Which quantity to keep constant when radius changes
    "last_a_c": v0*v0/r0,# Last centripetal acceleration value
    "last_w": w0,        # Last angular velocity value
    "last_v": v0,        # Last speed value
    "paused2": False,    # Additional pause flag (not used explicitly)
    "dir_v": "unchanged",# Last direction string for v
    "dir_w": "unchanged",# Last direction string for w
    "dir_a": "unchanged" # Last direction string for a_c
}

# -------------------- Setup figure and axes --------------------
plt.close("all")
fig = plt.figure(figsize=(12, 17))
fig.patch.set_facecolor("0.9")  # Light gray background for figure

# Main plot area for circular motion visualization
ax = fig.add_axes([0.15, 0.28, 0.70, 0.62])
ax.set_aspect("equal", adjustable="box")
ax.set_title("Uniform Circular Motion: r, v, a (centripetal) — stable viewport", fontsize=12)
ax.set_facecolor("#eaeaea")  # Slightly lighter gray background for plot

# Circle representing the path of motion
circle = Circle((0, 0), r0, edgecolor="k", facecolor="none", lw=1.6)
ax.add_patch(circle)

# Point representing the moving object on the circle
pt, = ax.plot([], [], "o", ms=14, color="blue", label="Point")

# Line representing radius vector (r)
r_line, = ax.plot([], [], color="tab:orange", lw=2.0, label="r")

# Quiver (arrow) representing velocity vector (v), tangent to circle
v_quiv = ax.quiver([0], [0], [0], [0], angles="xy", scale_units="xy", scale=1,
                   width=0.010, color="tab:green", label="v (tangent)")

# Quiver (arrow) representing centripetal acceleration vector (a), directed inward
a_quiv = ax.quiver([0], [0], [0], [0], angles="xy", scale_units="xy", scale=1,
                   width=0.010, color="tab:red", label="a_c = v²/r (inward)")

# Text box in plot for displaying current values of r, v, ω, and a_c
txt = ax.text(0.02, 0.98, "", transform=ax.transAxes, va="top", ha="left", family="monospace")

# Light gray lines for x and y axes
ax.axhline(0, color="0.85", lw=0.8)
ax.axvline(0, color="0.85", lw=0.8)

# Legend for vectors
ax.legend(loc="upper right")

# Feedback text area below the main plot for showing changes in v, ω, and a_c
ax_feedback = fig.add_axes([0.1, 0.06, 0.8, 0.03])
ax_feedback.axis("off")
feedback_text = ax_feedback.text(0.5, 0.5, "", ha="center", va="center", fontsize=10, family="monospace")

# -------------------- Helper functions for viewport limits --------------------
def apply_limits():
    """Apply current axis limits based on state['lim']."""
    lim = state["lim"]
    ax.set_xlim(-lim, lim)
    ax.set_ylim(-lim, lim)

def recompute_limits():
    """
    Recompute axis limits dynamically based on radius and speed,
    with padding to ensure vectors fit comfortably in view.
    """
    r = s_r.val
    v = s_v.val
    radius_of_envelope = np.hypot(r, K_V * v)
    state["lim"] = (1 + PAD_FRAC) * radius_of_envelope + PAD_ABS
    apply_limits()

# -------------------- Sliders for radius, speed, and initial angle --------------------
# Slider for radius r
ax_r  = fig.add_axes([0.10, 0.22, 0.80, 0.03])
s_r  = Slider(ax=ax_r,  label="Radius r", valmin=R_MIN, valmax=R_MAX, valinit=r0)

# Slider for speed v
ax_v  = fig.add_axes([0.10, 0.18, 0.80, 0.03])
s_v  = Slider(ax=ax_v,  label="Speed v",  valmin=V_MIN, valmax=V_MAX, valinit=v0)

# Slider for initial angle θ₀ (adjusted y-position to 0.12 to fit label in figure)
ax_th = fig.add_axes([0.10, 0.12, 0.80, 0.03])
s_th = Slider(ax=ax_th, label="Initial angle\nθ₀ [rad]", valmin=0.0, valmax=2*np.pi, valinit=theta0)

# -------------------- Check buttons to toggle vector visibility --------------------
from matplotlib.widgets import CheckButtons
ax_chk = fig.add_axes([0.75, 0.80, 0.20, 0.15], facecolor="#e0f0f0")
chk = CheckButtons(ax_chk, ["Show r", "Show v", "Show a_c"], [True, True, True])
ax_chk.set_title("Vectors", fontsize=10, pad=10, fontweight='bold', color='navy')

def toggle_vectors(label):
    """Toggle visibility of vectors r, v, and a_c based on check button."""
    if label == "Show r":
        r_line.set_visible(not r_line.get_visible())
    elif label == "Show v":
        v_quiv.set_visible(not v_quiv.get_visible())
    elif label == "Show a_c":
        a_quiv.set_visible(not a_quiv.get_visible())
    plt.draw()

chk.on_clicked(toggle_vectors)

# Set font size for check button labels
for lbl in chk.labels:
    lbl.set_fontsize(9)

# -------------------- Radio buttons to choose constant quantity when adjusting radius --------------------
from matplotlib.widgets import RadioButtons
ax_radio = fig.add_axes([0.05, 0.80, 0.20, 0.15], facecolor="#f0e0e0")
fig.text(0.05, 0.96, "Choose what to keep constant when adjusting radius", fontsize=11, fontweight="bold", color="darkred")
radio = RadioButtons(ax_radio, ["Constant v", "Constant a_c"], active=0)

def set_lock(label):
    """Set which quantity to keep constant when radius is changed."""
    state["lock"] = label

radio.on_clicked(set_lock)
state["lock"] = "Constant v"

# Set font size for radio button labels
for lbl in radio.labels:
    lbl.set_fontsize(9)

# -------------------- Pause/play button to control animation --------------------
ax_btn = fig.add_axes([0.43, 0.01, 0.14, 0.04])
btn = Button(ax_btn, "Pause")

def toggle_pause(_e):
    """Toggle paused state of the animation and update button label."""
    state["paused"] = not state["paused"]
    btn.label.set_text("Play" if state["paused"] else "Pause")

btn.on_clicked(toggle_pause)

# -------------------- Slider event handlers --------------------
def sync_from_v():
    """
    Update last centripetal acceleration based on current radius and speed.
    Prevent recursive updates by checking 'updating' flag.
    """
    if state["updating"]:
        return
    state["updating"] = True
    r = s_r.val
    v = s_v.val
    if r > 0:
        state["last_a_c"] = v*v / r
    state["updating"] = False
    recompute_limits()

def on_r_change(_):
    """
    Handler for radius slider changes.
    Adjust speed slider if 'Constant a_c' mode is selected to maintain centripetal acceleration.
    Update feedback text accordingly.
    """
    if state["updating"]:
        return
    r = s_r.val
    lock = state.get("lock", "Constant v")
    if lock == "Constant v":
        if r > 0:
            state["last_a_c"] = s_v.val*s_v.val / r
        feedback_text.set_text("Radius changed: Speed v kept constant")
    elif lock == "Constant a_c":
        a_c = state.get("last_a_c", 0.0)
        state["updating"] = True
        if r > 0 and a_c >= 0:
            v_new = np.sqrt(a_c * r)
            v_new = np.clip(v_new, V_MIN, V_MAX)
            s_v.set_val(v_new)
        state["updating"] = False
        feedback_text.set_text("Radius changed: Centripetal acceleration a_c kept constant")
    recompute_limits()

def on_v_change(_):
    """
    Handler for speed slider changes.
    Update last centripetal acceleration if 'Constant a_c' mode is selected.
    Update feedback text accordingly.
    """
    if state["updating"]:
        return
    lock = state.get("lock", "Constant v")
    r = s_r.val
    v = s_v.val
    if lock == "Constant v":
        feedback_text.set_text("Speed v changed: v kept constant")
        return
    elif lock == "Constant a_c":
        if r > 0:
            state["last_a_c"] = v*v / r
        else:
            state["last_a_c"] = 0.0
        feedback_text.set_text("Speed v changed: a_c kept constant")
    sync_from_v()

# Connect slider events to handlers
for slider, func in [(s_r, on_r_change), (s_v, on_v_change), (s_th, lambda _v: None)]:
    slider.on_changed(func)

# Set font size for slider labels
s_r.label.set_size(9)
s_v.label.set_size(9)
s_th.label.set_size(9)

# Initialize plot limits
recompute_limits()

# -------------------- Kinematics calculations --------------------
def kinematics(theta, r, v):
    """
    Compute position, velocity, and acceleration vectors for uniform circular motion.

    Parameters:
        theta: Current angular position (radians)
        r: Radius of circular path
        v: Linear speed

    Returns:
        position (x, y),
        velocity vector (vx, vy),
        acceleration vector (ax_, ay_),
        centripetal acceleration magnitude a_c
    """
    urx, ury = np.cos(theta), np.sin(theta)  # Unit vector in radial direction
    utx, uty = -np.sin(theta), np.cos(theta) # Unit vector tangent to circle (direction of velocity)
    x, y = r * urx, r * ury
    a_c = 0.0 if r <= 0 else v*v / r
    vx, vy = K_V * v * utx, K_V * v * uty
    ax_, ay_ = K_A * a_c * (-urx), K_A * a_c * (-ury)
    return (x, y), (vx, vy), (ax_, ay_), a_c

# -------------------- Animation update function --------------------
def update(_frame):
    """
    Update the positions and vectors for the moving point on the circle,
    update feedback text with changes in speed, angular velocity, and centripetal acceleration,
    and update the text box with current values.
    """
    if not state["paused"]:
        state["t"] += DT

    r = s_r.val
    v = s_v.val
    th0 = s_th.val
    w = 0.0 if r <= 0 else v / r
    theta = th0 + w * state["t"]

    (x, y), (vx, vy), (ax_, ay_), a_c = kinematics(theta, r, v)

    circle.set_radius(r)
    pt.set_data([x], [y])
    r_line.set_data([0.0, x], [0.0, y])
    v_quiv.set_offsets(np.array([[x, y]])); v_quiv.set_UVC(vx, vy)
    a_quiv.set_offsets(np.array([[x, y]])); a_quiv.set_UVC(ax_, ay_)

    apply_limits()

    # Compute changes in speed, angular velocity, and acceleration since last update
    dv = v - state.get("last_v", v)
    dw = w - state.get("last_w", w)
    da = a_c - state.get("last_a_c", a_c)

    def dir_str(d): return "increased" if d > 0 else ("decreased" if d < 0 else "unchanged")

    # Compute new directions
    new_dir_v = dir_str(dv)
    new_dir_w = dir_str(dw)
    new_dir_a = dir_str(da)

    # If lock is "Constant a_c", override new_dir_a to "unchanged"
    if state.get("lock", "Constant v") == "Constant a_c":
        new_dir_a = "unchanged"

    # Update stored directions according to instructions
    # For v
    if new_dir_v != "unchanged":
        if new_dir_v != state["dir_v"]:
            state["dir_v"] = new_dir_v
    # If new_dir_v is "unchanged", keep stored direction

    # For w
    if new_dir_w != "unchanged":
        if new_dir_w != state["dir_w"]:
            state["dir_w"] = new_dir_w

    # For a_c
    if new_dir_a != "unchanged":
        if new_dir_a != state["dir_a"]:
            state["dir_a"] = new_dir_a
    else:
        # If new_dir_a is "unchanged", keep stored direction as "unchanged"
        state["dir_a"] = "unchanged"

    feedback = (f"v {state['dir_v']}, "
                f"ω {state['dir_w']}, "
                f"a_c {state['dir_a']}")
    feedback_text.set_text(feedback)

    # Update last known values
    state["last_v"] = v
    state["last_w"] = w
    state["last_a_c"] = a_c

    # Update text box with current values
    txt.set_text(
        f"r = {r:5.2f} m\n"
        f"v = {v:5.2f} m/s\n"
        f"ω = {w:5.3f} rad/s\n"
        f"a_c = v²/r = {a_c:6.3f} m/s²"
    )
    return pt, r_line, v_quiv, a_quiv, circle, txt

# Create animation with update function called at intervals of DT seconds
ani = FuncAnimation(fig, update, interval=1000*DT, blit=False)

# Display the interactive plot
plt.show()