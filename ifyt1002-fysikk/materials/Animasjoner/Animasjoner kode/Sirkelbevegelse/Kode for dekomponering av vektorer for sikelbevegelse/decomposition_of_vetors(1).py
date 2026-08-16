"""
This script visualizes uniform circular motion, illustrating the radius vector (r), 
velocity vectors (v1 and v2) at angles separated by dtheta, and the centripetal acceleration vector (a).
It demonstrates how the change in velocity Δv over time Δt corresponds to the centripetal acceleration a_c,
pointing inward toward the center of the circular path.

The figure visualizes the centripetal acceleration vector a_c, which points 
inward toward the center of the circular path, and shows the velocity vectors at two close angles,
with the difference vector Δv illustrating the acceleration direction and magnitude.

"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
from matplotlib.animation import FuncAnimation
from matplotlib.widgets import Slider, Button
from matplotlib.patches import FancyArrowPatch

# import matplotlib; matplotlib.use("TkAgg")  # uncomment if window doesn't show

# ==========================
# Constants and Parameters
# ==========================
# Time step for animation updates (seconds)
DT = 0.02

R_MIN, R_MAX = 0.5, 5.0
V_MIN, V_MAX = 0.0, 6.0

# Arrow length scaling factors:
# These convert physical units (m/s, m/s²) to plot units for better visualization
K_V = 0.35         # 1 m/s corresponds to 0.35 axis units
K_A = 0.5          # 1 m/s² corresponds to 0.5 axis units

# Viewport padding to keep vectors comfortably visible within plot limits
PAD_FRAC = 0.35    # 35% margin relative to max radius/velocity
PAD_ABS  = 0.75    # Fixed padding in axis units

# Small angle difference for velocity vectors (radians)
DTHETA = 0.15

# ==========================
# Initial Physical State
# ==========================
# Initial radius (m), speed (m/s), and initial angle (rad)
r0 = 3.0
v0 = 2.0
w0 = v0 / r0      # ω = v / r for uniform circular motion
theta0 = 0.0

# State dictionary to keep track of time, pause state, control locks, etc.
# 'lock' controls which quantity (v, ω, or a) remains constant when radius changes
state = {
    "t": 0.0,
    "paused": False,
    "updating": False,
    "control": "v",
    "lim": 6.0,
    "lock": "Constant v",
    "last_a_c": v0*v0/r0,  # Last computed centripetal acceleration a_c = v²/r
    "last_w": w0,          # Last angular velocity for "Constant ω"
    "paused2": False,
    "dtheta": DTHETA
}

# ==========================
# Helper functions
# ==========================

def kinematics(theta, r, v):
    """
    Compute position, velocity, acceleration, and angular velocity vectors for uniform circular motion.

    Parameters:
        theta : float
            Angular position (radians).
        r : float
            Radius of the circle (meters).
        v : float
            Speed (m/s).

    Returns:
        pos : tuple of floats
            (x, y) position coordinates.
        vel : tuple of floats
            (vx, vy) velocity components.
        acc : tuple of floats
            (ax, ay) acceleration components.
        omega : float
            Angular velocity (rad/s).
    """
    omega = 0.0 if r <= 0 else v / r
    x = r * np.cos(theta)
    y = r * np.sin(theta)
    vx = -v * np.sin(theta)
    vy = v * np.cos(theta)
    ax = -omega * omega * x
    ay = -omega * omega * y
    return (x, y), (vx, vy), (ax, ay), omega

def recompute_limits(r, v):
    """
    Compute axis limits based on radius and velocity for visualization.

    Parameters:
        r : float
            Radius (meters).
        v : float
            Speed (m/s).

    Returns:
        lim : float
            Axis limit value.
    """
    lim = (1.0 + PAD_FRAC) * max(r, K_V * v) + PAD_ABS
    return lim

def apply_limits(ax, lim):
    """
    Apply axis limits to a matplotlib axis.

    Parameters:
        ax : matplotlib.axes.Axes
            The axes to set limits on.
        lim : float
            The axis limit value.
    """
    ax.set_xlim(-lim, lim)
    ax.set_ylim(-lim, lim)


###############################################################################
# ==================== FIGURE 2: Centripetal Acceleration Visualization ============================
###############################################################################
# This second figure illustrates the centripetal acceleration vector a_c.
# The acceleration vector points inward toward the center of the circular path.
# It also shows two velocity vectors v1 and v2 separated by a small angle dtheta,
# and the difference vector Δv = v2 - v1 which points inward.
# The change in velocity Δv over the time interval Δt corresponds to the centripetal acceleration a_c.

fig2 = plt.figure(figsize=(6,6))
fig2.patch.set_facecolor("0.92")
# Enlarged axes, leaving some margin for controls
ax2 = fig2.add_axes([0.12, 0.25, 0.76, 0.65])
ax2.set_aspect('equal', adjustable='box')
ax2.set_title("Centripetal Acceleration Visualization\n(Assuming same |⃗v| for both vectors)")
ax2.set_facecolor("#eaeaea")
ax2.axhline(0, color="0.85", lw=0.8)
ax2.axvline(0, color="0.85", lw=0.8)

# Circle representing the path with dashed linestyle
circle2 = Circle((0, 0), r0, edgecolor="k", facecolor="none", lw=1.5, ls="--")
ax2.add_patch(circle2)

# Point moving on the circle
pt2, = ax2.plot([], [], "o", ms=12, color="blue", label="Point")

#
# Velocity vector at time t (blue, color-blind friendly)
v_quiv_t = ax2.quiver([0], [0], [0], [0], angles="xy", scale_units="xy", scale=1,
                      width=0.012, color="#0072B2", label="v1")

# Velocity vector at time t + dtheta (orange, color-blind friendly)
v_quiv_tdt = ax2.quiver([0], [0], [0], [0], angles="xy", scale_units="xy", scale=1,
                      width=0.012, color="#E69F00", label="v2")

v1_dashed_arrow = FancyArrowPatch((0,0),(0,0),arrowstyle='-|>',mutation_scale=16,color="#0072B2",lw=2,ls='--',alpha=0.7)
v2_dashed_arrow = FancyArrowPatch((0,0),(0,0),arrowstyle='-|>',mutation_scale=16,color="#E69F00",lw=2,ls='--',alpha=0.7)
ax2.add_patch(v1_dashed_arrow)
ax2.add_patch(v2_dashed_arrow)
# Δv dashed arrow (color-blind friendly orange-red, dashed)
delta_v_dashed_arrow = FancyArrowPatch((0,0),(0,0),
                                       arrowstyle='-|>', mutation_scale=16,
                                       color="#D55E00", lw=2, ls='--', alpha=0.9, zorder=5)
ax2.add_patch(delta_v_dashed_arrow)

# Centripetal acceleration vector (green, color-blind friendly) with reduced width
a_c_quiv = ax2.quiver([0], [0], [0], [0], angles="xy", scale_units="xy", scale=1,
                      width=0.012, color="#009E73", label=r"$\vec{a}_c$")

# Markers for velocity origins on the circle
pt_t, = ax2.plot([], [], "o", ms=9, color="green", markeredgecolor="k", label=r"$\vec{v_1}$ origin", zorder=3)
pt_tdt, = ax2.plot([], [], "o", ms=9, color="orange", markeredgecolor="k", label=r"$\vec{v_2}$ origin", zorder=3)

# Sliders for radius, velocity, and initial angle (arranged vertically)
slider_ax_r = fig2.add_axes([0.12, 0.18, 0.75, 0.03], facecolor='0.95')
s_r = Slider(slider_ax_r, 'Radius (r)', R_MIN, R_MAX, valinit=r0, valstep=0.01)

slider_ax_v = fig2.add_axes([0.12, 0.14, 0.75, 0.03], facecolor='0.95')
s_v = Slider(slider_ax_v, 'Speed (v)', V_MIN, V_MAX, valinit=v0, valstep=0.01)

slider_ax_th = fig2.add_axes([0.12, 0.10, 0.75, 0.03], facecolor='0.95')
s_th = Slider(slider_ax_th, 'Initial Angle (θ)', 0.0, 2*np.pi, valinit=theta0, valstep=0.01)

# New slider for Δθ (angle difference) in degrees
slider_ax_dtheta = fig2.add_axes([0.12, 0.06, 0.75, 0.03], facecolor='0.95')
s_dtheta = Slider(slider_ax_dtheta, 'Δθ (degrees)', 30, 180, valinit=np.degrees(DTHETA), valstep=1)

def update_dtheta(val):
    state["dtheta"] = np.radians(s_dtheta.val)
s_dtheta.on_changed(update_dtheta)

# Pause button for second figure (moved below sliders and adjusted position)
ax_btn2 = fig2.add_axes([0.4, 0.015, 0.2, 0.04])
btn2 = Button(ax_btn2, "Pause")
def toggle_pause2(_e):
    """
    Toggle pause state for second figure's animation.
    """
    state["paused2"] = not state.get("paused2", False)
    btn2.label.set_text("Play" if state["paused2"] else "Pause")
btn2.on_clicked(toggle_pause2)

# Add a new axes for decomposition text on the left side of the circle plot
# Make the box much narrower so it does not cover the visualization
ax_text = fig2.add_axes([0.05, 0.3, 0.03, 0.6])
ax_text.axis('off')

def update_fig2(_frame):
    """
    Update function for the centripetal acceleration visualization figure.

    - Advances time if not paused.
    - Computes velocity vectors v1 at angle theta and v2 at angle theta + dtheta.
    - Computes Δv = v2 - v1, representing the change in velocity over Δt.
    - Draws velocity vectors v1, v2, and the Δv vector anchored at tip of v1.
    - Updates circle and point position.
    - Adds text labels near tips of v1, v2, and Δv.
    - Displays explanatory text and magnitudes of centripetal acceleration and Δv,
      noting that Δv/Δt corresponds to a_c.
    """
    if not state.get("paused2", False):
        state["t"] += DT

    r = s_r.val
    v = s_v.val
    th0 = s_th.val
    dtheta = np.radians(s_dtheta.val)
    # Compute angular velocity ω as in main update
    w = 0.0 if r <= 0 else v / r
    # Slow down the angular velocity in second figure for clearer visualization
    theta = th0 + 0.3 * w * state["t"]

    # Position and velocity at current angle theta (v1)
    (x, y), (vx1, vy1), (_, _), _ = kinematics(theta, r, v)
    # Velocity at angle theta + dtheta (v2)
    (x2, y2), (vx2, vy2), (_, _), _ = kinematics(theta + dtheta, r, v)

    # Compute delta v vector components
    dvx = vx2 - vx1
    dvy = vy2 - vy1

    # Compute magnitude of delta v vector
    delta_v_mag = np.hypot(dvx, dvy)

    # Compute delta t
    dt = dtheta / w if w > 0 else 0.0

    circle2.set_radius(r)
    pt2.set_data([x], [y])

    # Scale velocity vectors for visualization
    scale_factor_v = 1.0
    vx1_scaled, vy1_scaled = vx1 * scale_factor_v, vy1 * scale_factor_v
    vx2_scaled, vy2_scaled = vx2 * scale_factor_v, vy2 * scale_factor_v

    # Δv vector has its true geometric length (equal to the vector difference v₂ − v₁)
    dvx_scaled = dvx
    dvy_scaled = dvy

    # Compute centripetal acceleration magnitude and components
    a_c = v*v / r if r > 0 else 0.0
    # Compute centripetal acceleration vector direction (inward, toward center)
    theta_mid = theta + dtheta / 2
    ax_c = -a_c * np.cos(theta_mid)
    ay_c = -a_c * np.sin(theta_mid)
    # Analytical magnitude of delta v
    delta_v_mag_theory = 2 * v * np.sin(dtheta / 2)

    # Draw velocity vector v1 at point position (solid, blue)
    v_quiv_t.set_offsets(np.array([[x, y]]))
    v_quiv_t.set_UVC(vx1_scaled, vy1_scaled)

    # Draw velocity vector v2 at its own position (solid, orange)
    v_quiv_tdt.set_offsets(np.array([[x2, y2]]))
    v_quiv_tdt.set_UVC(vx2_scaled, vy2_scaled)

    # Compute midpoint along the circle arc (not the straight line)
    x_mid = r * np.cos(theta_mid)
    y_mid = r * np.sin(theta_mid)

    # Update dashed arrows positions with arrowheads (using visible arrowstyle and mutation_scale)
    v1_dashed_arrow.set_positions((x_mid, y_mid), (x_mid + vx1_scaled, y_mid + vy1_scaled))
    v2_dashed_arrow.set_positions((x_mid, y_mid), (x_mid + vx2_scaled, y_mid + vy2_scaled))
    # Update Δv dashed arrow between the tips of the dashed velocity vectors
    delta_v_dashed_arrow.set_positions(
        (x_mid + vx1_scaled, y_mid + vy1_scaled),
        (x_mid + vx2_scaled, y_mid + vy2_scaled)
    )

    # Draw centripetal acceleration vector at midpoint (solid, green)
    a_c_quiv.set_offsets(np.array([[x_mid, y_mid]]))
    a_c_quiv.set_UVC(ax_c, ay_c)

    # Update markers on the circle to highlight where velocity vectors originate
    pt_t.set_data([x], [y])
    pt_tdt.set_data([x2], [y2])

    # Remove previous text labels if any
    if hasattr(update_fig2, "labels"):
        for label in update_fig2.labels:
            label.remove()
    update_fig2.labels = []

    # Add text label near tip of velocity vector v1 (solid)
    label_offset_v = 0.25 * scale_factor_v
    label_v1 = ax2.text(
        x + vx1_scaled + label_offset_v, y + vy1_scaled + label_offset_v,
        r"$\vec{v_1}$", color="#0072B2",
        fontsize=12, fontweight="bold", ha="left", va="bottom",
        bbox=dict(facecolor='white', alpha=0.8, edgecolor='none'), zorder=10
    )
    update_fig2.labels.append(label_v1)

    # Add text label near tip of velocity vector v2 (solid)
    label_v2_solid = ax2.text(
        x2 + vx2_scaled + label_offset_v, y2 + vy2_scaled + label_offset_v,
        r"$\vec{v_2}$", color="#E69F00",
        fontsize=12, fontweight="bold", ha="left", va="bottom",
        bbox=dict(facecolor='white', alpha=0.8, edgecolor='none'), zorder=10
    )
    update_fig2.labels.append(label_v2_solid)

    # Add text label near tip of dashed velocity vector v1
    label_v1_dashed = ax2.text(
        x_mid + vx1_scaled + label_offset_v, y_mid + vy1_scaled + label_offset_v,
        r"$\vec{v_1}$", color="#0072B2",
        fontsize=12, fontweight="bold", ha="left", va="bottom", alpha=0.7,
        bbox=dict(facecolor='white', alpha=0.8, edgecolor='none'), zorder=10
    )
    update_fig2.labels.append(label_v1_dashed)

    # Add text label near tip of dashed velocity vector v2
    label_v2_dashed = ax2.text(
        x_mid + vx2_scaled + label_offset_v, y_mid + vy2_scaled + label_offset_v,
        r"$\vec{v_2}$", color="#E69F00",
        fontsize=12, fontweight="bold", ha="left", va="bottom", alpha=0.7,
        bbox=dict(facecolor='white', alpha=0.8, edgecolor='none'), zorder=10
    )
    update_fig2.labels.append(label_v2_dashed)

    # Label for centripetal acceleration (anchored at midpoint, green)
    label_offset_ac = 0.25
    label_ac = ax2.text(
        x_mid + ax_c + label_offset_ac,
        y_mid + ay_c + label_offset_ac,
        r"$\vec{a}_c$",
        color="#009E73", fontsize=13, fontweight="bold",
        ha="left", va="bottom",
        bbox=dict(facecolor='white', alpha=0.8, edgecolor='none'), zorder=10
    )
    update_fig2.labels.append(label_ac)

    # Add a clear Δv label for the dashed arrow (color-blind friendly orange-red)
    label_offset_dv_dashed = 0.25
    label_dv_dashed_arrow = ax2.text(
        (x_mid + vx1_scaled + vx2_scaled) / 2 + label_offset_dv_dashed,
        (y_mid + vy1_scaled + vy2_scaled) / 2 + label_offset_dv_dashed,
        r"$\Delta \vec{v}$",
        color="#D55E00", fontsize=12, fontweight="bold",
        ha="left", va="bottom", alpha=0.9,
        bbox=dict(facecolor='white', alpha=0.8, edgecolor='none'), zorder=10
    )
    update_fig2.labels.append(label_dv_dashed_arrow)

    # Add decomposition text block at left side of plot in ax_text
    decomposition_text = (
        r"$\vec{v}_1 = v(-\sin\theta, \cos\theta)$" + "\n"
        r"$\vec{v}_2 = v(-\sin(\theta+\Delta\theta), \cos(\theta+\Delta\theta))$" + "\n"
        r"$\Delta \vec{v} = \vec{v}_2 - \vec{v}_1$" + "\n"
        r"$\Delta t = \Delta\theta / \omega$" + "\n"
        r"$\vec{a}_c = \frac{\Delta \vec{v}}{\Delta t}$" + "\n"
        r"$a_c = \frac{v^2}{r}$" + "\n"
        r"$\vec{a}_c = -a_c(\cos\theta_\mathrm{mid}, \sin\theta_\mathrm{mid})$" + "\n"
        f"Numerical values:\n"
        f"v = {v:.3f} m/s\n"
        f"θ = {theta:.3f} rad\n"
        f"Δθ = {np.degrees(dtheta):.1f}°\n"
        f"ω = {w:.3f} rad/s\n"
        f"Δt = {dt:.3f} s\n"
        f"$a_c$ = {a_c:.3f} m/s²"
    )
    ax_text.clear()
    ax_text.axis('off')
    ax_text.text(0, 1, decomposition_text, fontsize=10, fontweight="normal", va="top", ha="left", color="black",
                 bbox=dict(facecolor='white', alpha=0.7, edgecolor='none'))

    # Adjust axis limits to fit all vectors comfortably
    lim2 = (1.0 + PAD_FRAC) * np.hypot(r, K_V * v) + PAD_ABS
    ax2.set_xlim(-lim2, lim2)
    ax2.set_ylim(-lim2, lim2)

    plt.draw()

    return pt2, v_quiv_t, v_quiv_tdt, v1_dashed_arrow, v2_dashed_arrow, delta_v_dashed_arrow, a_c_quiv, circle2, pt_t, pt_tdt

# Initialize the labels attribute for text removal in update_fig2
update_fig2.labels = []

# Create animations for both figures

ani2 = FuncAnimation(fig2, update_fig2, interval=1000*DT, blit=False)

plt.show()

