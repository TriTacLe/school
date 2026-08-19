---
type: note
status: active
project: uct
course: EGS3012S
tags: [uct, atmospheric-science, climate, solutions]
---

# Solutions, Tests 1 to 3 (2024)

Worked answers for the three 2024 class tests in `past-papers/`. None of them ship a memo. The only paper in the folder that already has one is [[../past-papers/Test 1 2026 model answer.pdf|Test 1 2026 model answer]] (it is actually the 15 August 2025 paper, Matikinca's climate-and-impacts version), so use that one as the marker's own style guide and this note for the Conradie thermodynamics and dynamics papers.

Negative marking on all three: correct +1, wrong -0.25, blank 0. That changes strategy. Guessing blind across five options has expected value 0.2 - 0.2 = 0, so a pure guess is worth nothing but costs nothing. Eliminating even one option makes guessing positive. Never leave a question blank once you have ruled anything out.

Constants throughout are the ones on [[../materials/reference/Formula sheet.pdf|the formula sheet]]: g = 9.8 m/s2, R = 287 J/kg/K, Gamma_d = 0.01 K/m, Gamma_s = 0.006 K/m, Z_LCL = 125(T - Td) in metres.

## Test 1A 2024, MCQ

| # | Ans | Why |
| - | --- | --- |
| 1 | B | A low on a constant-height chart and a low height on a constant-pressure chart are the same thing seen two ways. Where the column is cold or shallow, pressure at fixed height is low and the height of a fixed pressure surface is low. |
| 2 | A | The wet-bulb depression T - Tw is a direct measure of how much evaporation the air can take. Bigger depression means drier air, so RH falls. |
| 3 | C | Dew point tracks the water vapour present, not the temperature. No vapour was added, so Td stays at 20 C. Only the dew point depression changed, from 0 to 15 K. |
| 4 | A | Returns to its original position is the definition of a stable layer. |
| 5 | B | Stratosphere, roughly 15 to 35 km, and the ozone heating is what makes the stratospheric inversion. |
| 6 | C | 25 - 0.01 x 500 = 20 C. |
| 7 | C | Supercooled means still liquid below 0 C, which needs the absence of ice nuclei. |
| 8 | C | Condensation, gas to liquid, releases Lv. Evaporation, melting and sublimation all absorb it. |
| 9 | A | Wet-bulb temperature is exactly the temperature reached by evaporative cooling to saturation. This is the number heat-stress work uses. |
| 10 | C | Tar roughly 0.05 to 0.10. Snow is the highest at 0.8 to 0.9. |
| 11 | C | Pressure is the only one that must decrease monotonically, because it is the weight of everything above. Temperature reverses in the stratosphere, RH and Td are free to do anything. |
| 12 | D | Alto- prefix means mid-level, 2 to 7 km. Cirro- is high, strato- and nimbo- are low. |
| 13 | B | Hail needs the deep updraft of a cumulonimbus to keep recycling the stone above the freezing level. |
| 14 | A | Stefan-Boltzmann gives more total energy and Wien puts the peak at shorter wavelength. Both change the same way, so the pairing in A is the only self-consistent one. |
| 15 | B | Work from E_OLR = epsilon sigma T^4. The absorbed solar is fixed, so if the effective emissivity of the surface-plus-atmosphere system as seen from space drops, T must rise to keep emitting the same flux. Greenhouse gases do exactly that. Albedo (A, E) changes the input side, not the emission side. |
| 16 | A | Tv = T(1 + 0.61X). With X = 0 the correction vanishes. |
| 17 | B | Geopotential height weights by the actual g, which falls with altitude, so Phi < z above the surface and the gap grows with height. At 200 hPa, near 12 km, it is about 20 m. |
| 18 | C | Thickness goes with mean virtual temperature. Warmest wins first, moistest breaks the tie: 20 C at 95 percent RH. |
| 19 | B | Evaporation absorbs latent heat from the air it falls through. That is the mechanism behind downdrafts and gust fronts. |
| 20 | D | 2^4 = 16, from Stefan-Boltzmann. |
| 21 | E | Cold upwelling next to warm land gives advection fog and a stratocumulus deck under the subsidence inversion. Cumulonimbus needs deep instability, which the inversion kills. |
| 22 | C | Same logic as 18, one level higher. 35 C with Td 17 C is the warmest column with the joint-highest moisture. |
| 23 | A | Clausius-Clapeyron is about saturation vapour pressure es, not mixing ratio and not pressure. About 7 percent per K near room temperature. |
| 24 | D | Z_LCL = 125(T - Td). Only the gap matters, not the absolute temperature. 15 and 14 gives 125 m, the smallest. |
| 25 | D | Least stable means highest equivalent potential temperature: warmest and moistest. 32 C at 55 percent RH beats everything else on both counts. |
| 26 | B | Rising means expanding and cooling at lower pressure, and cooling towards Td raises RH. B is the only row with all three signs right. |

## Test 1A 2024, calculations

**(A) Wien.** lambda_max = C / T, so T = C / lambda_max = 2897e-6 / 0.7e-6 = 4138.6, so **T = 4139 K**.

Sanity check: the real photosphere is near 5800 K and peaks near 0.5 micron. The 0.7 micron in the question is red light, so a cooler answer is the right direction.

**(B1) Cloud base.** Z_LCL = 125(T - Td) = 125(20 - 16) = 500 m, so **500 m**.

**(B2) Temperature at 1 km.** Two segments, because the parcel saturates at the LCL.

- 0 to 500 m dry: 20 - 0.01(500) = 15 C
- 500 to 1000 m saturated: 15 - 0.006(500) = 12 C

**12 C**. The single most common error here is running Gamma_d all the way to 1 km, which gives 10 C.

**(B3) Pressure at 300 m.** Neutrally stable means the layer is on a dry adiabat, so Gamma = Gamma_d = 0.01 K/m and the constant-lapse-rate hypsometric form applies:

P2 = P1 (T2/T1)^b with b = g / (Gamma R) = 9.8 / (0.01 x 287) = 3.4146

T1 = 293.15 K, T2 = 293.15 - 0.01(300) = 290.15 K

P2 = 1013.00 x (290.15/293.15)^3.4146 = 1013.00 x 0.96549 = 978.04 hPa

**97804 Pa**. Note the question asks for pascals, so convert. Working in hPa and forgetting the factor 100 is a 2-mark loss for one keystroke.

## Test 2A 2024, MCQ

| # | Ans | Why |
| - | --- | --- |
| 1 | A | Around a high, the centrifugal term points outward and adds to the outward pressure gradient force, so a weaker Coriolis, meaning a faster wind, restores balance. Anticyclonic gradient wind is supergeostrophic; cyclonic is subgeostrophic. |
| 2 | B | Geostrophic balance assumes friction is negligible and f is not near zero. Only the free upper troposphere satisfies both. |
| 3 | E | In the Southern Hemisphere cyclonic is clockwise, and a surface low converges inward and rises. |
| 4 | C | Wind direction is always the direction it blows from. 90 degrees is east. |
| 5 | D | Solar declination swings from +23.5 to -23.5, so noon elevation at any fixed latitude swings by 2 x 23.5 = 47 degrees. Latitude does not enter. |
| 6 | A | Katabatic flow accelerates because the drainage air is denser than its surroundings at the same level. Gravity alone acts on everything equally, and what is left after subtracting the hydrostatic pressure gradient is buoyancy. If your lecturer phrased it as gravity in the notes, answer as taught, but the physics is the buoyancy term. |
| 7 | C | Gradient wind balances PGF, Coriolis and centrifugal. Cyclostrophic drops Coriolis; sea and valley breezes are thermally driven and too small-scale for Coriolis to matter. |
| 8 | B | Adiabatic means no heat exchange with the environment. A is conduction, C and D are latent heat exchanges. |
| 9 | B | The subsiding branch of the Hadley cell at roughly 20 to 30 degrees, the horse latitudes. That is where the Sahara, Kalahari, Namib and Atacama sit. |
| 10 | B | The sea breeze is driven by the land-sea temperature contrast. Cooling the sea sharpens it. Wet soil (A) and cloud (D) both suppress land heating, and offshore background flow (C) opposes the circulation. |
| 11 | B | Needs enough CAPE to matter and little enough CIN to be released. B has CAPE 1000 with CIN only 400. A has more CAPE but CIN 1500, which almost nothing lifts. |
| 12 | A | w_max = sqrt(2 CAPE), so the strongest updraft goes with the largest CAPE, 2000 J/kg. |
| 13 | A | Cloud top sits at the equilibrium level. Lowest EL pressure means highest EL, so 130 hPa. |
| 14 | C | Cloud base sits at the LCL. Highest LCL pressure means lowest LCL, so 970 hPa. |
| 15 | A | In an inversion, potential temperature increases sharply with height, so any displaced parcel is restored no matter how it is lifted. B and C describe the opposite. |
| 16 | D | Z_LCL = 125(3 - 1) = 250 m, and 200 m is the only option in range. |
| 17 | D | Coriolis is what turns the wind away from the down-gradient direction. Friction (A) then adds the cross-isobar component near the surface, but the question is about the free-air deflection. |
| 18 | C | The marine boundary layer is shallow by day because the sea barely warms, but it has almost no diurnal cycle, whereas the land layer collapses to a thin stable layer at night. Averaged over 24 hours the marine one can be the thicker of the two. |
| 19 | C | Removing mass from the column faster than it is resupplied lowers surface pressure, which is how a surface low deepens. |
| 20 | A | The false one. Thermal wind is parallel to the thickness contours, that is to the isotherms, not to the geostrophic wind. B, C and D are all correct statements. |
| 21 | A | The entrainment zone mixes free-atmosphere air downward into the growing mixed layer. That is how the daytime boundary layer deepens. |
| 22 | C | The equilibrium level is the highest of the four, so it has the lowest pressure. |
| 23 | C | The false one. A seasonal reversal is a monsoon. The sea breeze is diurnal. |

## Test 2A 2024, calculations

**(A1) Geostrophic wind direction.** Geopotential height falls 5200 to 5180 m eastward, and is constant north to south, so the gradient points due west and low heights lie to the east. In the Southern Hemisphere the geostrophic wind blows with low height on its **right**. Put the low to the east and you must be facing north, so the wind blows towards the north, which is a **southerly wind, bearing 180 degrees**.

Check the hemisphere carefully. The same geometry in the Northern Hemisphere gives 000 degrees. This is the single most common sign error on the paper.

**(A2) Coriolis parameter.** f = 2 Omega sin(phi), Omega = 2 pi / 86400 = 7.2722e-5 s^-1.

|f| = 2 (7.2722e-5) sin(34) = 2 (7.2722e-5)(0.55919) = **8.13e-5 s^-1**

**(A3) Geostrophic wind speed.**

|Vg| = (g / |f|)(dZ / dn) = (9.8 / 8.133e-5)(20 / 100000) = 120494 x 2.0e-4 = 24.1

**24 m/s.** Units matter: 100 km must go in as 1.0e5 m.

**(B) Skew-T log-P read-off.** The three labelled levels are the LCL at 848 hPa, the LFC at 467 hPa and the EL at 227 hPa, in that order going up. The freezing level is marked separately at 658 hPa.

| Part | Answer | How to get it |
| ---- | ------ | ------------- |
| B1 | Td at 700 hPa is about 0 C | Follow the 700 hPa isobar to the green curve, then follow the isotherm through that point down and to the left. It lands on 0. |
| B2 | About 600 hPa | Cloud sits where the environmental T and Td curves converge. Red and green almost touch near 600 hPa and are far apart everywhere below 700. |
| B3 | 467 hPa | Continue to rise by itself is the definition of the level of free convection. |
| B4 | 848 hPa | Cloud base is the LCL. |
| B5 | Neutrally stable with respect to a dry air parcel | From 1000 hPa up to about 900 hPa the red environmental curve lies on top of the grey parcel curve, and the grey curve below the LCL is a dry adiabat. Equal lapse rates means neutral. |
| B6 | About 900 hPa | Above 900 the red curve bends sharply right, warming with height, up to its peak near 848. That kink is the base of the capping inversion, and it is also where the well-mixed layer stops. |

Reading B5 and B6 together tells the whole story: a dry well-mixed boundary layer up to 900 hPa, capped by an inversion 900 to 848, with the LCL sitting right at the top of that cap.

## Test 3B 2024, MCQ

| # | Ans | Why |
| - | --- | --- |
| 1 | FALSE | Seasonal forecasting predicts the seasonal aggregate, because deterministic daily skill runs out after roughly two weeks. |
| 2 | TRUE | Positive feedbacks like ice-albedo amplify, negative ones like the Planck response damp. |
| 3 | C | f = 0 at the equator, so there is no Coriolis torque to spin up a vortex. A has the hemispheres backwards and D is the wrong sign of the SST effect. |
| 4 | C | Wavenumber k is how many full waves fit around a latitude circle, so lambda = 360 / 3 = 120 degrees. |
| 5 | B | A sea breeze front is a convergence line, which is a lifting mechanism. Lightning (D) is a product of the storm, not a trigger. |
| 6 | C | Climate is the statistics over decades. The other three are single events. |
| 7 | D | Projection, attribution and palaeo simulation are all standard uses. |
| 8 | A | The RCPs are 2.6, 4.5, 6.0 and 8.5. There is no 3.5. |
| 9 | D | Shear is what tilts and stretches horizontal vorticity into the vertical. |
| 10 | C | The West African Monsoon is a regional circulation, not an oscillating mode with a remote correlation pattern. |
| 11 | C | The forecast cycle is previous forecast plus new observations, blended by data assimilation, to give the analysis that initialises the next run. Reanalysis is a retrospective product, so A and B are out. |
| 12 | A | Surface charts show pressure, fronts and highs and lows. Accumulated rainfall is a separate product. |
| 13 | E | Emissions are classified by origin (natural, anthropogenic), by mobility (stationary, mobile) and by phase (gas, particulate). All of these are source categories. |
| 14 | D | You parameterise what you understand but cannot resolve. If the process is not understood, you cannot write the parameterisation in the first place. |
| 15 | A | Backwards. To resolve a feature the grid must be several times **smaller** than the feature, not bigger. |
| 16 | B | Probability comes from the spread of an ensemble. D is wrong because taking the mean throws the spread away, which is the very thing that carries the probability. |
| 17 | C | A fails on always, B has coastal lows as deep (they are shallow, below about 850 hPa), D has the inversion suppressing rather than facilitating rain, E fails on always. |
| 18 | D | Coal-fired energy generation dominates the SA emissions inventory. |
| 19 | B | CO is a primary vehicle emission. Ozone is secondary, formed photochemically. |
| 20 | D | Daytime surface heating drives thermal turbulence and a deep mixed layer, which dilutes pollution. The trapping case is the stable night-time layer. |
| 21 | B | O3, SO2 and NO2 all damage vegetation as well as lungs. CO is essentially a human-health pollutant only. |
| 22 | D | Upper divergence maximises downstream of the trough axis, and that is where a surface low forms and deepens. |
| 23 | D | The warm sector ahead of the cold front is the moist tropical air the system is drawing in. |
| 24 | D | Four-quadrant jet-streak model: upper convergence sits in the poleward entrance and equatorward exit quadrants, and surface highs sit under upper convergence. |
| 25 | A | A cut-off low is by definition a cold-cored low that has closed off from the westerly flow. |

## Test 3B 2024, Section B

Both questions hang on one synoptic chart, South African Weather Service, 2011, the 22nd, 00:00Z, with the month deliberately blanked out. The same chart appears as Figure 4 in the 2022 exam, so learning it once covers both papers.

**What is actually on the Day 0 chart**

- A deep mid-latitude cyclone just southwest of the Cape, near 34 S 15 E, centre below 1006 hPa, with a cold front trailing northwest into the South Atlantic and a warm front to the east.
- A second, much shallower low near 33 S 22 E over the south coast, ringed at 1010. This is a coastal low, running east ahead of the front.
- A continental anticyclone at 1024 hPa over the interior, centred near Botswana and Limpopo.
- The South Atlantic Anticyclone near 1032 hPa at roughly 40 S 5 W, positioned to ridge in behind the front.
- A separate 1004 hPa low with fronts in the southwest Indian Ocean near 40 S 45 E, and a weak low over Madagascar.
- Plotted surface temperatures around 13 C at Alexander Bay, Windhoek and Pretoria, 14 to 17 C around the Cape, 20 C at Port Elizabeth, 16 to 20 C on the KZN coast.

**The month.** A 1024 hPa continental high, a cold front reaching the southwestern Cape, the South Atlantic High poised to ridge, and 13 C over the interior at 02:00 local. That is the textbook winter pattern, so **June to August, most likely July**. Say why, do not just write a month. In summer the interior high is replaced by a heat low, the front would not reach that far north, and interior overnight temperatures would be higher.

**Upper air, Day 0.** Draw a 500 hPa trough whose axis lies **west** of the surface low, that is the westward tilt with height that marks a developing baroclinic system, with a ridge over the interior above the surface high. Label L in the trough and H in the ridge.

**Upper air, Day +1.** The trough moves east and may close off. Keep the tilt if the system is still deepening, and make it vertical or reverse it if you show it as mature or occluding.

**Surface, Day +1.** Move the low and its front east and slightly poleward, sweep the cold front across the southern Cape, push the coastal low east ahead of it, and ridge the South Atlantic High in behind, over the west coast and the Cape. That ridging high is what gives the post-frontal south to southwesterly flow.

**The city table.** Values are indicative, not unique. What earns marks is that the numbers are consistent with the systems you drew.

| | Day 0 Cape Town | Day 0 Johannesburg | Day +1 Cape Town | Day +1 Johannesburg |
| - | - | - | - | - |
| Tmax | 18 C | 18 C | 14 C | 18 C |
| Tmin | 13 C | 4 C | 9 C | 4 C |
| Wind speed | 12 m/s | 3 m/s | 15 m/s gusting | 3 m/s |
| Wind direction | NW | variable, light | SW to S | variable, light |
| Rain | Yes, pre-frontal and frontal | No | Yes, post-frontal showers | No |
| System | Pre-frontal NW flow ahead of the approaching cold front | Continental anticyclone | Ridging South Atlantic High behind the front | Continental anticyclone |

The pattern the marker is looking for: Cape Town warm, humid and windy from the northwest before the front, then a wind shift to the southwest, a temperature drop and showers behind it. Johannesburg stays dry, clear and light-winded under the high all the way through, with a cold night because clear skies over the high plateau radiate freely.
