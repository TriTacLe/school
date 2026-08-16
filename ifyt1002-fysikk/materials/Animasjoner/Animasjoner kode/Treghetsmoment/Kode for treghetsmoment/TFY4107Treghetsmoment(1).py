import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Rectangle
from matplotlib.widgets import RadioButtons, Slider
from matplotlib.lines import Line2D

plt.close("all")

# ---- Legemer: I = C·M·R² ----
BODIES = {
    "Kompakt kule":   {"C_str": "2/5",  "C_val": 2/5,   "color": "dodgerblue"},
    "Hul kule":       {"C_str": "2/3",  "C_val": 2/3,   "color": "orangered"},
    "Sylinder":       {"C_str": "1/2",  "C_val": 1/2,   "color": "limegreen"},
    "Ring":           {"C_str": "1",    "C_val": 1.0,   "color": "magenta"},
    "Kjegle (kompakt)": {"C_str": "3/10", "C_val": 3/10, "color": "mediumorchid"},
    "Punktpartikkel":   {"C_str": "1",    "C_val": 1.0,  "color": "deepskyblue"},
    "Sylinderskall":    {"C_str": "1",    "C_val": 1.0,  "color": "goldenrod"},
    "Tynn ring":        {"C_str": "1",    "C_val": 1.0,  "color": "cyan"},
}

# ---- Startverdier ----
shape = "Kompakt kule"
M1_0, M2_0 = 2.0, 2.0
R1_0, R2_0 = 1.0, 1.5
delta_deg_0 = 45.0
extra_active = False

# ---- Layout ----
fig = plt.figure(figsize=(11, 7))
fig.patch.set_facecolor("#e9ecef")
ax = plt.axes([0.07, 0.30, 0.55, 0.65]); ax.set_facecolor("#f8f9fa")
ax_info = plt.axes([0.68, 0.30, 0.30, 0.65]); ax_info.set_facecolor("#f3f3f3"); ax_info.axis("off")

# Sliders
ax_M1  = plt.axes([0.07, 0.20, 0.55, 0.03])
ax_R1  = plt.axes([0.07, 0.16, 0.55, 0.03])
ax_M2  = plt.axes([0.07, 0.12, 0.55, 0.03])
ax_R2  = plt.axes([0.07, 0.08, 0.55, 0.03])
ax_dph = plt.axes([0.07, 0.04, 0.55, 0.03])

sM1   = Slider(ax_M1, "M₁ [kg]",  0.5, 10.0, valinit=M1_0)
sR1   = Slider(ax_R1, "R₁ [m]",   0.2, 2.0,  valinit=R1_0)
sM2   = Slider(ax_M2, "M₂ [kg]",  0.5, 10.0, valinit=M2_0)
sR2   = Slider(ax_R2, "R₂ [m]",   0.2, 2.0,  valinit=R2_0)
sDPh  = Slider(ax_dph, "Δφ [°]",  0.0, 360.0, valinit=delta_deg_0)

# ---- Legemevalg ----
names = list(BODIES.keys())
left_names, right_names = names[:4], names[4:]

# flytt panelet litt ned
rax1 = plt.axes([0.68, 0.16, 0.14, 0.13])
rax2 = plt.axes([0.84, 0.16, 0.14, 0.13])

radio1 = RadioButtons(rax1, left_names,  active=0)
radio2 = RadioButtons(rax2, right_names, active=0)

def style_radios():
    for radio in (radio1, radio2):
        for i, (circ, lab) in enumerate(zip(radio.circles, radio.labels)):
            txt = lab.get_text()
            circ.set_edgecolor("#333"); circ.set_linewidth(1.6); circ.set_radius(0.06)
            circ.set_facecolor(BODIES[txt]["color"] if txt == shape else "none")
            lab.set_color(BODIES[txt]["color"])

def on_radio(label):
    global shape
    shape = label
    style_radios()
    on_change_generic(None)

radio1.on_clicked(on_radio)
radio2.on_clicked(on_radio)
style_radios()

# ---- Checkboks ----
ax_chk = plt.axes([0.68, 0.02, 0.26, 0.05]); ax_chk.set_axis_off()
bx, by, sz = 0.03, 0.14, 0.22 
chk_box = Rectangle((bx, by), sz, sz, transform=ax_chk.transAxes,
                    facecolor="#e9ecef", edgecolor="#444", linewidth=1.6)
ax_chk.add_patch(chk_box)
tick = Line2D([bx+0.20*sz, bx+0.45*sz, bx+0.80*sz],
              [by+0.55*sz, by+0.30*sz, by+0.80*sz],
              transform=ax_chk.transAxes, color="#2ca02c", linewidth=2.8,
              visible=extra_active)
ax_chk.add_line(tick)
ax_chk.text(bx + sz + 0.08, by + 0.02, "Ekstra partikkel",
            transform=ax_chk.transAxes, va="bottom", fontsize=11, color="#111")

def on_checkbox_click(event):
    global extra_active
    if event.inaxes is not ax_chk: return
    xin, yin = ax_chk.transAxes.inverted().transform((event.x, event.y))
    if bx <= xin <= bx + sz and by <= yin <= by + sz:
        extra_active = not extra_active
        tick.set_visible(extra_active)
        on_change_generic(None)

fig.canvas.mpl_connect("button_press_event", on_checkbox_click)

# ---- Scene ----
ax.set_aspect("equal")
ax.set_xlim(-2.6, 2.6); ax.set_ylim(-2.0, 2.0)
ax.set_title("Treghetsmoment – flere punktpartikler på ulike radier")

track1 = Circle((0, 0), R1_0, fill=False, lw=1.5, ls="--", color="teal", alpha=0.8)
track2 = Circle((0, 0), R2_0, fill=False, lw=1.5, ls="--", color="teal", alpha=0.4)
ax.add_patch(track1); ax.add_patch(track2)

marker1, = ax.plot([R1_0], [0], "o", ms=20, color=BODIES[shape]["color"])
marker2, = ax.plot([R2_0], [0], "o", ms=20, color=BODIES[shape]["color"], alpha=0.0)

r_line1, = ax.plot([0, R1_0], [0, 0], color="teal", lw=2)
r_text1 = ax.text(R1_0/2, 0.05, "r₁", color="teal", ha="center", fontsize=14)
r_line2, = ax.plot([], [], color="teal", lw=2, ls=":")
r_text2 = ax.text(0, 0, "", color="teal", ha="center", fontsize=14)

ax.plot(0, 0, "o", ms=8, color="crimson")
ax.text(0.05, 0.05, "Rotasjonsakse (ut av planet)", color="crimson", fontsize=9)

# ---- Beregning ----
def inertia_single(shp, M, R):
    return BODIES[shp]["C_val"] * M * R**2

# --- Info-elementer ---
info_elems = {}          # R1, M1, R2, M2, Tot
I_parts = {"1": {}, "2": {}}  

def render_I_line(y, idx, Cstr, M, R, I):
    parts = {}
    x = 0.04; fs = 10
    parts["lhs"] = ax_info.text(x, y, f"I{idx} = ", fontsize=fs, transform=ax_info.transAxes); x += 0.09
    parts["C"]   = ax_info.text(x, y, f"{Cstr}", fontsize=fs, color="black", transform=ax_info.transAxes); x += 0.06
    parts["dot1"]= ax_info.text(x, y, "·", fontsize=fs, transform=ax_info.transAxes); x += 0.02
    parts["M"]   = ax_info.text(x, y, f"({M:.2f} kg)", fontsize=fs, color="black", transform=ax_info.transAxes); x += 0.14
    parts["dot2"]= ax_info.text(x, y, "·", fontsize=fs, transform=ax_info.transAxes); x += 0.02
    parts["R"]   = ax_info.text(x, y, f"({R:.2f} m)²", fontsize=fs, color="black", transform=ax_info.transAxes); x += 0.18
    parts["eq"]  = ax_info.text(x, y, " = ", fontsize=fs, transform=ax_info.transAxes); x += 0.04
    parts["res"] = ax_info.text(x, y, f"{I:.3f} kg·m²", fontsize=fs, color="black", transform=ax_info.transAxes)
    return parts

def update_info(shp, M1, R1, M2, R2, I1, I2, Itot, extra):
    Cstr   = BODIES[shp]["C_str"]
    color  = BODIES[shp]["color"]
    shape_lower = shp.lower()

    ax_info.clear(); ax_info.axis("off")
    info_elems.clear(); I_parts["1"].clear(); I_parts["2"].clear()

    y = 0.95; dy = 0.09
    ax_info.text(0.02, y, "I = C·M·R²", fontsize=12); y -= dy
    ax_info.text(0.02, y, f"for {shape_lower}:  C = {Cstr}", fontsize=11, color=color); y -= (dy*1.2)

    ax_info.text(0.02, y, "Partikkel 1:", fontsize=11); y -= dy
    info_elems["R1"] = ax_info.text(0.04, y, f"R₁ = {R1:.2f} m", fontsize=10); y -= dy
    info_elems["M1"] = ax_info.text(0.04, y, f"M₁ = {M1:.2f} kg", fontsize=10); y -= dy
    I_parts["1"] = render_I_line(y, "₁", Cstr, M1, R1, I1); y -= (dy*1.2)

    if extra:
        ax_info.text(0.02, y, "Partikkel 2:", fontsize=11); y -= dy
        info_elems["R2"] = ax_info.text(0.04, y, f"R₂ = {R2:.2f} m", fontsize=10); y -= dy
        info_elems["M2"] = ax_info.text(0.04, y, f"M₂ = {M2:.2f} kg", fontsize=10); y -= dy
        I_parts["2"] = render_I_line(y, "₂", Cstr, M2, R2, I2); y -= (dy*1.2)
        info_elems["Tot"] = ax_info.text(0.02, y, f"Totalt: I = I₁ + I₂ = {Itot:.3f} kg·m²", fontsize=11, color=color)
    else:
        info_elems["Tot"] = ax_info.text(0.02, y, f"Totalt: I = I₁ = {I1:.3f} kg·m²", fontsize=11, color=color)

# ---- Geometri ----
def update_geometry():
    R1, R2 = sR1.val, sR2.val
    dphi = np.radians(sDPh.val)

    track1.set_radius(R1); track2.set_radius(R2)

    x1, y1 = R1*np.cos(0.0), R1*np.sin(0.0)
    marker1.set_data([x1], [y1]); r_line1.set_data([0, x1], [0, y1])
    if R1 > 0:
        nx1, ny1 = (-y1/R1, x1/R1)
        r_text1.set_position((x1*0.5 + 0.15*nx1, y1*0.5 + 0.15*ny1))
    r_text1.set_text("r₁")

    if extra_active:
        x2, y2 = R2*np.cos(dphi), R2*np.sin(dphi)
        marker2.set_data([x2], [y2]); marker2.set_alpha(1.0)
        r_line2.set_data([0, x2], [0, y2])
        if R2 > 0:
            nx2, ny2 = (-y2/R2, x2/R2)
            r_text2.set_position((x2*0.5 + 0.15*nx2, y2*0.5 + 0.15*ny2))
        r_text2.set_text("r₂")
    else:
        marker2.set_alpha(0.0); r_line2.set_data([], []); r_text2.set_text("")

# Highlight (én debounce-timer)
RED = "#d32f2f"
reset_timer = None
to_reset = [] 

def set_color_and_size(text, color=None, scale=None):
    if text is None: return (None, None)
    old_c = text.get_color(); old_s = text.get_fontsize()
    if color: text.set_color(color)
    if scale: text.set_fontsize(old_s*scale)
    return (old_c, old_s)

def queue_reset(text_obj, old_tuple):
    global to_reset
    to_reset.append((text_obj, old_tuple))

def start_reset_timer(ms=1500):
    global reset_timer, to_reset
    if reset_timer is not None:
        reset_timer.stop()
    reset_timer = fig.canvas.new_timer(interval=ms)
    def _reset():
        global to_reset
        for t, (c, s) in to_reset:
            if t is not None:
                if c is not None: t.set_color(c)
                if s is not None: t.set_fontsize(s)
        to_reset = []
        fig.canvas.draw_idle()
    reset_timer.add_callback(_reset)
    reset_timer.start()

def highlight_changed(which):
    if which in ("M1","R1") and "1" in I_parts:
        part = I_parts["1"]
        var_key = "M1" if which=="M1" else "R1"
        if var_key in info_elems:
            queue_reset(info_elems[var_key], set_color_and_size(info_elems[var_key], RED, 1.20))
        target = "M" if which=="M1" else "R"
        queue_reset(part.get(target), set_color_and_size(part.get(target), RED, 1.25))
        queue_reset(part.get("res"), set_color_and_size(part.get("res"), RED, 1.20))
    if which in ("M2","R2") and extra_active and "2" in I_parts:
        part = I_parts["2"]
        var_key = "M2" if which=="M2" else "R2"
        if var_key in info_elems:
            queue_reset(info_elems[var_key], set_color_and_size(info_elems[var_key], RED, 1.20))
        target = "M" if which=="M2" else "R"
        queue_reset(part.get(target), set_color_and_size(part.get(target), RED, 1.25))
        queue_reset(part.get("res"), set_color_and_size(part.get("res"), RED, 1.20))
    # Totalt I
    if info_elems.get("Tot"):
        queue_reset(info_elems["Tot"], set_color_and_size(info_elems["Tot"], RED, 1.15))

    fig.canvas.draw_idle()
    start_reset_timer(1500)  # debounce: én timer som nullstiller alt

# ---- Callbacks ----
def on_change_generic(changed=None):
    I1 = inertia_single(shape, sM1.val, sR1.val)
    I2 = inertia_single(shape, sM2.val, sR2.val) if extra_active else 0.0
    Itot = I1 + I2
    update_info(shape, sM1.val, sR1.val, sM2.val, sR2.val, I1, I2, Itot, extra_active)
    update_geometry()
    
    marker1.set_color(BODIES[shape]["color"]); marker2.set_color(BODIES[shape]["color"])
    style_radios()
    fig.canvas.draw_idle()
    if changed in {"M1","R1","M2","R2"}:
        highlight_changed(changed)

def on_M1(_): on_change_generic("M1")
def on_R1(_): on_change_generic("R1")
def on_M2(_): on_change_generic("M2")
def on_R2(_): on_change_generic("R2")
def on_DPh(_): on_change_generic(None)

# Wire-up
sM1.on_changed(on_M1); sR1.on_changed(on_R1)
sM2.on_changed(on_M2); sR2.on_changed(on_R2)
sDPh.on_changed(on_DPh)

# Init
style_radios()
on_change_generic(None)
plt.show()