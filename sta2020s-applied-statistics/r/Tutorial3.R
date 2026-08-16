# =====================================================
# Stick Insect and Maize Yield Data Preparation & Analysis
# =====================================================

# -----------------------------
# Create long-format data frame: Stick Insects
# -----------------------------
stick_insects <- data.frame(
  Season = rep(c("Spring", "Summer", "Autumn", "Winter"), each = 6),
  Species = rep(rep(c("Megacrania", "Extatosoma"), each = 3), times = 4),
  Count = c(
    # Spring
    15, 18, 22,   13, 12, 11,
    # Summer
    12, 14, 16,   15, 19, 21,
    # Autumn
    10, 11, 9,    23, 25, 26,
    # Winter
    6, 8, 7,      30, 29, 31
  )
)

write.csv(stick_insects, "stick_insects.csv", row.names = FALSE)

# -----------------------------
# Create long-format data frame: Maize Yield
# -----------------------------

library(tidyverse)

# Set seed for reproducibility
set.seed(42)

# Define factors
seed_types <- c("A-402", "B-894", "C-952")
fertilizers <- c("Fert I", "Fert II", "Fert III", "Fert IV", "Fert V")

# Sample size per treatment
n_per_group <- 12

# Create a data frame of all treatment combinations
treatments <- expand.grid(SeedType = seed_types, Fertilizer = fertilizers)

# Define mean and sd for each combination (could be modified to induce interaction or SD differences)
set.seed(123)
treatments$Mean <- runif(nrow(treatments), 95, 110)       # random means between 95 and 110
treatments$SD <- runif(nrow(treatments), 3, 6)            # random SDs between 3 and 6

# Simulate data
simulated_data <- treatments |>
  rowwise() |>
  mutate(
    Yield = list(rnorm(n_per_group, mean = Mean, sd = SD))
  ) |>
  tidyr::unnest(Yield) |>
  dplyr::select(SeedType, Fertilizer, Yield)


simulated_data$Yield <- round(simulated_data$Yield, 2)
simulated_data <- simulated_data[sample(nrow(simulated_data)),]

write.csv(simulated_data, "maize_yield.csv", row.names = FALSE)


# =====================================================
# STICK INSECTS: Analysis 
# =====================================================

# Load and shuffle stick insect data
stick_insects <- read.csv("Data/stick_insects.csv")

# EDA 

summary(stick_insects)
stick_insects$Season <- as.factor(stick_insects$Season)
stick_insects$Species <- as.factor(stick_insects$Species)

# -----------------------------
# Assumption Checks
# -----------------------------

# Boxplot and stripchart
boxplot(Count ~ Season + Species, data = stick_insects,
        main = "Boxplot of Stick Insect Counts by Treatment")
stripchart(Count ~ Season + Species, data = stick_insects,
           vertical = TRUE, add = TRUE, method = "jitter", pch = 20, col = "blue")

# Standard deviations by treatment group
tapply(stick_insects$Count, list(stick_insects$Season, stick_insects$Species), sd)

# Q-Q plots for selected treatment combinations
par(mfrow = c(2, 2))  # Arrange plots in 2x2 grid

qqnorm(subset(stick_insects, Season == "Spring" & Species == "Megacrania")$Count,
       main = "Q-Q: Spring, Megacrania")
qqline(subset(stick_insects, Season == "Spring" & Species == "Megacrania")$Count)

qqnorm(subset(stick_insects, Season == "Summer" & Species == "Megacrania")$Count,
       main = "Q-Q: Summer, Megacrania")
qqline(subset(stick_insects, Season == "Summer" & Species == "Megacrania")$Count)

qqnorm(subset(stick_insects, Season == "Spring" & Species == "Extatosoma")$Count,
       main = "Q-Q: Spring, Extatosoma")
qqline(subset(stick_insects, Season == "Spring" & Species == "Extatosoma")$Count)

qqnorm(subset(stick_insects, Season == "Autumn" & Species == "Extatosoma")$Count,
       main = "Q-Q: Autumn, Extatosoma")
qqline(subset(stick_insects, Season == "Autumn" & Species == "Extatosoma")$Count)

par(mfrow = c(1, 1))  # Reset plotting layout

# Dotchart of counts
dotchart(stick_insects$Count,
         labels = paste(stick_insects$Season, stick_insects$Species),
         main = "Dotchart of Stick Insect Counts",
         cex = 0.7)

# -----------------------------
# Calculate Means and Effects
# -----------------------------

# Treatment means
(treatment_means <- tapply(stick_insects$Count, list(stick_insects$Season, stick_insects$Species), mean))

# Marginal means
(species_means <- tapply(stick_insects$Count, stick_insects$Species, mean))
(season_means <- tapply(stick_insects$Count, stick_insects$Season, mean))

# Grand mean
(grand_mean <- mean(stick_insects$Count))

# Effects (deviation from grand mean)
(species_effects <- species_means - grand_mean)  # Should sum to zero
(season_effects <- season_means - grand_mean)

# -----------------------------
# Fit Two-Way ANOVA Model
# -----------------------------

mod <- aov(Count ~ Season + Species + Season:Species, data = stick_insects)

# Estimated means and effects
model.tables(mod, type = "means", se = TRUE)
model.tables(mod, type = "effects", se = TRUE)

# ANOVA table
summary(mod)

# -----------------------------
# Interaction Plot
# -----------------------------
# Reorder the factor levels of Season
stick_insects$Season <- factor(stick_insects$Season, levels = c("Spring", "Summer", "Autumn", "Winter"))

# Now plot with the new order
interaction.plot(stick_insects$Season, stick_insects$Species, stick_insects$Count,
                 col = c("red", "blue"), pch = c(1, 2), lty = c(1, 2),
                 main = "Interaction Plot: Count by Season and Species")


# =====================================================
# MAIZE YIELD: Analysis 
# =====================================================

# Load and shuffle stick insect data
maize_yield <- read.csv("Data/maize_yield.csv")


# EDA 

summary(maize_yield)
maize_yield$SeedType <- as.factor(maize_yield$SeedType)
maize_yield$Fertilizer <- as.factor(maize_yield$Fertilizer)

# -----------------------------
# Assumption Checks
# -----------------------------

# Boxplot and stripchart
boxplot(Yield ~ SeedType + Fertilizer, data = maize_yield,
        main = "Boxplot of Maize yield by Treatment")
stripchart(Yield ~ SeedType + Fertilizer, data = maize_yield,
           vertical = TRUE, add = TRUE, method = "jitter", pch = 20, col = "blue")

# Standard deviations by treatment group
sds <- tapply(maize_yield$Yield, list(maize_yield$SeedType, maize_yield$Fertilizer), sd)
max(sds) / min(sds)


# Q-Q plots for selected treatment combinations,
par(mfrow = c(2, 2))  # Arrange plots in 2x2 grid

qqnorm(subset(maize_yield, SeedType == "A-402" & Fertilizer == "Fert II")$Yield,
       main = "Q-Q: Spring, Megacrania")
qqline(subset(maize_yield, SeedType == "A-402" & Fertilizer == "Fert II")$Yield)

qqnorm(subset(maize_yield, SeedType == "B-894" & Fertilizer == "Fert IV")$Yield,
       main = "Q-Q: B-894, Fert IV")
qqline(subset(maize_yield, SeedType == "B-894" & Fertilizer == "Fert IV")$Yield)


qqnorm(subset(maize_yield, SeedType == "C-952" & Fertilizer == "Fert III")$Yield,
       main = "Q-Q: C-952, Fert III")
qqline(subset(maize_yield, SeedType == "C-952" & Fertilizer == "Fert III")$Yield)

qqnorm(subset(maize_yield, SeedType == "C-952" & Fertilizer == "Fert V")$Yield,
       main = "Q-Q: C-952, Fert V")
qqline(subset(maize_yield, SeedType == "C-952" & Fertilizer == "Fert V")$Yield)


par(mfrow = c(1, 1))  # Reset plotting layout

# Dotchart of Yields
dotchart(maize_yield$Yield,
         labels ="",
         main = "Dotchart of Stick Insect Yields",
         cex = 0.7)

# -----------------------------
# Calculate Means and Effects
# -----------------------------

# Treatment means
(treatment_means <- tapply(maize_yield$Yield, list(maize_yield$SeedType, maize_yield$Fertilizer), mean))

# Marginal means
(Fertilizer_means <- tapply(maize_yield$Yield, maize_yield$Fertilizer, mean))
(SeedType_means <- tapply(maize_yield$Yield, maize_yield$SeedType, mean))

# Grand mean
(grand_mean <- mean(maize_yield$Yield))

# Effects (deviation from grand mean)
(Fertilizer_effects <- Fertilizer_means - grand_mean)  # Should sum to zero
(SeedType_effects <- SeedType_means - grand_mean)

# -----------------------------
# Fit Two-Way ANOVA Model
# -----------------------------

mod <- aov(Yield ~ SeedType + Fertilizer + SeedType:Fertilizer, data = maize_yield)

# Estimated means and effects
model.tables(mod, type = "means", se = TRUE)
model.tables(mod, type = "effects", se = TRUE)

# ANOVA table
summary(mod)


# -----------------------------
# Interaction Plot
# -----------------------------


interaction.plot(maize_yield$SeedType, maize_yield$Fertilizer, maize_yield$Yield,
                 col = c("red", "blue","green","orange","pink"), pch = c(1, 2), lty = c(1, 2),
                 main = "Interaction Plot: Yield by SeedType and Fertilizer")

# =====================================================
# ADDITIONS: Tutorial 3 datasets + interaction plots + ANOVA
# (Personality × Volume, Bacterial growth, Factorial A×B)
# =====================================================

# -----------------------------
# Q5: Personality × Volume (2×2, n=5 per cell) — Interaction Plot + ANOVA
# -----------------------------

# NOTE: The question gives cell means and an ANOVA table, but not the raw 20 scores.
# We therefore:
#  (i) create a small data frame of the given means for the interaction plot, and
# (ii) store the given ANOVA table (and p-values) as an R object.

personality_volume_means <- data.frame(
  Personality = factor(c("Extrovert","Extrovert","Introvert","Introvert"),
                       levels = c("Extrovert","Introvert")),
  Volume      = factor(c("High","Low","High","Low"),
                       levels = c("High","Low")),
  MeanAttitude = c(10.6, 7.0, 7.2, 6.0)
)

# Interaction plot from means (lines show mean attitude vs volume by personality)
interaction.plot(
  x.factor     = personality_volume_means$Volume,
  trace.factor = personality_volume_means$Personality,
  response     = personality_volume_means$MeanAttitude,
  type = "b",
  pch  = c(1, 2),
  lty  = c(1, 2),
  main = "Interaction Plot (Means): Attitude by Volume and Personality",
  xlab = "Volume", ylab = "Mean Attitude"
)

# -----------------------------
# Q6: Bacterial Growth (4×3 factorial, r=2) — Data + ANOVA + Interaction Plot
# -----------------------------

bacteria_growth <- data.frame(
  Temp = factor(rep(c(25,30,35,40), each = 6)),
  Rep  = factor(rep(rep(c(1,2), each = 3), times = 4)),
  pH   = factor(rep(c("5.5","6.5","7.5"), times = 8),
                levels = c("5.5","6.5","7.5")),
  Growth = c(
    9,18,36,
    11,20,44,
    13,23,27,
    17,27,33,
    18,27,23,
    22,33,27,
    22,20, 7,
    28,24,13
  )
)

# Fit two-way ANOVA with interaction
mod_bacteria <- aov(Growth ~ Temp * pH, data = bacteria_growth)
summary(mod_bacteria)

# Interaction plot (means by cell)
interaction.plot(
  x.factor     = bacteria_growth$pH,
  trace.factor = bacteria_growth$Temp,
  response     = bacteria_growth$Growth,
  type = "b",
  pch  = 1,
  lty  = 1,
  main = "Interaction Plot: Bacterial Growth by pH and Temperature",
  xlab = "pH", ylab = "Growth"
)


# -----------------------------
# Q9: Factorial Study A × B (2×3, n=5 per cell) — Data + ANOVA + Interaction Plot
# -----------------------------

factorial_AB <- data.frame(
  A = factor(rep(c("A1","A2"), each = 15)),
  B = factor(rep(rep(c("B1","B2","B3"), each = 5), times = 2),
             levels = c("B1","B2","B3")),
  Y = c(
    # A1
    5,3,3,8,6,    9,9,13,6,8,    3,8,3,3,3,
    # A2
    0,2,0,0,3,    0,0,0,5,0,     0,3,7,5,5
  )
)

# Fit two-way ANOVA with interaction
mod_factorial_AB <- aov(Y ~ A * B, data = factorial_AB)
summary(mod_factorial_AB)

# Interaction plot
interaction.plot(
  x.factor     = factorial_AB$B,
  trace.factor = factorial_AB$A,
  response     = factorial_AB$Y,
  type = "b",
  pch  = c(1, 2),
  lty  = c(1, 2),
  main = "Interaction Plot: Response by B and A",
  xlab = "Factor B", ylab = "Response"
)

# (Optional) Cell means table (handy for memo / interpretation)
tapply(factorial_AB$Y, list(factorial_AB$A, factorial_AB$B), mean)

