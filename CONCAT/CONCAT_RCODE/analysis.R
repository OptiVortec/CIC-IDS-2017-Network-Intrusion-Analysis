library(tidyverse)
library(ggcorrplot)
library(scales)

base_path <- "/Users/antoniogonzalez/.cache/kagglehub/datasets/chethuhn/network-intrusion-dataset/versions/1"

# ---- LOAD ----
mon       <- read.csv(file.path(base_path, "Monday-WorkingHours.pcap_ISCX.csv"))
tue       <- read.csv(file.path(base_path, "Tuesday-WorkingHours.pcap_ISCX.csv"))
wed       <- read.csv(file.path(base_path, "Wednesday-workingHours.pcap_ISCX.csv"))
thur_infl <- read.csv(file.path(base_path, "Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv"))
thur_web  <- read.csv(file.path(base_path, "Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv"))
fri_m     <- read.csv(file.path(base_path, "Friday-WorkingHours-Morning.pcap_ISCX.csv"))
fri_port  <- read.csv(file.path(base_path, "Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv"))
fri_ddos  <- read.csv(file.path(base_path, "Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv"))

# ---- CLEAN ----
dfs <- list(mon, tue, wed, thur_infl, thur_web, fri_m, fri_port, fri_ddos)
dfs <- lapply(dfs, function(df) { names(df) <- trimws(names(df)); df$Label <- trimws(df$Label); df })
list2env(setNames(dfs, c("mon","tue","wed","thur_infl","thur_web","fri_m","fri_port","fri_ddos")), envir = .GlobalEnv)

# ---- 1. STATISTICAL TEST ----
heartbleed   <- wed       %>% filter(Label == "Heartbleed")   %>% pull(Average.Packet.Size)
infiltration <- thur_infl %>% filter(Label == "Infiltration") %>% pull(Average.Packet.Size)
cat("Heartbleed mean packet size:  ", mean(heartbleed), "\n")
cat("Infiltration mean packet size:", mean(infiltration), "\n")
wilcox.test(heartbleed, infiltration)

# ---- 2. CLASS DISTRIBUTION ----
all_data <- map_dfr(list.files(base_path, pattern = "*.csv", full.names = TRUE), ~{
  df <- read.csv(.x)
  names(df) <- trimws(names(df))
  df$Label  <- trimws(df$Label)
  df %>% select(Label)
})

all_data %>%
  count(Label, sort = TRUE) %>%
  ggplot(aes(x = reorder(Label, n), y = n, fill = Label)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  scale_y_continuous(labels = comma) +
  labs(title = "Class Distribution — CIC-IDS-2017", x = NULL, y = "Sample Count") +
  theme_minimal()

# ---- 3. BOXPLOT ----
bind_rows(
  data.frame(Label = "Heartbleed",   Size = heartbleed),
  data.frame(Label = "Infiltration", Size = infiltration)
) %>%
  ggplot(aes(x = Label, y = Size, fill = Label)) +
  geom_boxplot(show.legend = FALSE) +
  scale_y_log10(labels = comma) +
  labs(title = "Average Packet Size: Heartbleed vs Infiltration",
       y = "Packet Size (log scale)", x = NULL) +
  theme_minimal()

# ---- 4. FEATURE CORRELATION HEATMAP ----
png("correlation_heatmap.png", width = 1200, height = 1000, res = 150)
wed %>%
  filter(Label != "BENIGN") %>%
  sample_n(min(500, nrow(.))) %>%
  select(where(is.numeric)) %>%
  select(Average.Packet.Size, Flow.Duration,
         Total.Length.of.Fwd.Packets, Total.Length.of.Bwd.Packets,
         Flow.Bytes.s, Fwd.Packets.s) %>%
  cor(use = "complete.obs") %>%
  ggcorrplot(lab = TRUE,
             title = "Feature Correlations — Attack Traffic",
             tl.cex = 10,
             lab_size = 3)
dev.off()
