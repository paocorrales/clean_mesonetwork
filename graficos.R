library(metR)
library(ggplot2)
library(data.table)


tmp_obs <- ReadNetCDF("../Prueba_prep/ana/obs_t.nc")
tmp_prep <- ReadNetCDF("../Prueba_prep/ana/prep_t.nc")
tmp_bkg <- ReadNetCDF("../Prueba_prep/ana/bkg_t.nc")

u_obs <- ReadNetCDF("../Prueba_prep/ana/obs_umet.nc")
u_prep <- ReadNetCDF("../Prueba_prep/ana/prep_umet.nc")
u_bkg <- ReadNetCDF("../Prueba_prep/ana/bkg_umet.nc")

qv_obs <- ReadNetCDF("../Prueba_prep/ana/obs_q.nc")
qv_prep <- ReadNetCDF("../Prueba_prep/ana/prep_q.nc")
qv_bkg <- ReadNetCDF("../Prueba_prep/ana/bkg_q.nc")

map <- setDT(fortify(rnaturalearth::ne_states(country = c("Argentina"))))
setnames(map, "long", "lon")


ggplot(tmp_obs, aes(lon, lat)) +
  geom_contour_fill(aes(z = temp-tmp_bkg$temp), na.fill = TRUE) +
  geom_path(data = map, aes(group = group), color = "grey20", size = 0.3) +
  scale_x_continuous(name = "Lon", limits = c(-67, -56), expand = c(0,0)) +
  scale_y_continuous(name = "Lat", limits = c(-37, -25), expand = c(0,0)) +
  coord_map() +
  theme_bw()


ggplot(tmp_obs, aes(lon, lat)) +
  geom_contour_fill(aes(z = temp-tmp_bkg$temp), na.fill = TRUE,
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour2(aes(z = temp-tmp_bkg$temp), color = "black", size = 0.1, binwidth = 0.1,
                breaks = AnchorBreaks(0, exclude = 0)) +
  geom_path(data = map, aes(group = group), color = "grey20", size = 0.3) +
  scale_fill_divergent(name = "ANA-BK", 
                       guide = guide_colorbar(barwidth = 10, 
                                              barheight = 0.5, 
                                              breaks = seq(-1e3, 1e3, 2e4))) +
  scale_x_continuous(name = "Lon", limits = c(-67, -56), expand = c(0,0)) +
  scale_y_continuous(name = "Lat", limits = c(-37, -25), expand = c(0,0)) +
  ggtitle("Temperatura potencial") +
  coord_map() +
  theme_minimal() +
  theme(legend.position="bottom",
        legend.title.align = 0.5,
        legend.margin=margin(t=-0.3, r=0, b=0, l=0, unit="cm"),
        legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 8),
        panel.ontop = TRUE)


ggplot(spd_obs, aes(lon, lat)) +
  geom_contour_fill(aes(z = umet), na.fill = TRUE,
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour2(aes(z = umet-spd_bkg$umet), color = "black", size = 0.1, binwidth = 1,
                breaks = AnchorBreaks(0, exclude = 0)) +
  geom_path(data = map, aes(group = group), color = "grey20", size = 0.3) +
  scale_fill_divergent(name = "ANA-BK", 
                       guide = guide_colorbar(barwidth = 10, 
                                              barheight = 0.5, 
                                              breaks = seq(-1e3, 1e3, 2e4))) +
  scale_x_continuous(name = "Lon", limits = c(-67, -56), expand = c(0,0)) +
  scale_y_continuous(name = "Lat", limits = c(-37, -25), expand = c(0,0)) +
  ggtitle("Velocidad del viento") +
  coord_map() +
  theme_minimal() +
  theme(legend.position="bottom",
        legend.title.align = 0.5,
        legend.margin=margin(t=-0.3, r=0, b=0, l=0, unit="cm"),
        legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 8),
        panel.ontop = TRUE)


ggplot(qv_obs, aes(lon, lat)) +
  geom_contour_fill(aes(z = qv-qv_bkg$qv), na.fill = TRUE,
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour2(aes(z = qv-qv_bkg$qv), color = "black", size = 0.1, binwidth = 0.00005,
                breaks = AnchorBreaks(0, exclude = 0)) +
  geom_path(data = map, aes(group = group), color = "grey20", size = 0.3) +
  scale_fill_divergent(name = "ANA-BK", 
                       guide = guide_colorbar(barwidth = 10, 
                                              barheight = 0.5, 
                                              breaks = seq(-1e3, 1e3, 2e4))) +
  scale_x_continuous(name = "Lon", limits = c(-67, -56), expand = c(0,0)) +
  scale_y_continuous(name = "Lat", limits = c(-37, -25), expand = c(0,0)) +
  ggtitle("Humedad específica") +
  coord_map() +
  theme_minimal() +
  theme(legend.position="bottom",
        legend.title.align = 0.5,
        legend.margin=margin(t=-0.3, r=0, b=0, l=0, unit="cm"),
        legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 8),
        panel.ontop = TRUE)
#==================================================================================

ggplot(tmp_obs, aes(lon, lat)) +
  geom_contour_fill(aes(z = temp-tmp_prep$temp), na.fill = TRUE,
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour2(aes(z = temp-tmp_prep$temp), color = "black", size = 0.1, binwidth = 0.1,
                breaks = AnchorBreaks(0, exclude = 0)) +
  geom_path(data = map, aes(group = group), color = "grey20", size = 0.3) +
  scale_fill_divergent(name = "ANA-BK", 
                       guide = guide_colorbar(barwidth = 10, 
                                              barheight = 0.5, 
                                              breaks = seq(-1e3, 1e3, 2e4))) +
  scale_x_continuous(name = "Lon", limits = c(-67, -56), expand = c(0,0)) +
  scale_y_continuous(name = "Lat", limits = c(-37, -25), expand = c(0,0)) +
  ggtitle("Temperatura potencial") +
  coord_map() +
  theme_minimal() +
  theme(legend.position="bottom",
        legend.title.align = 0.5,
        legend.margin=margin(t=-0.3, r=0, b=0, l=0, unit="cm"),
        legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 8),
        panel.ontop = TRUE)


ggplot(qv_obs, aes(lon, lat)) +
  geom_contour_fill(aes(z = qv-qv_prep$qv), na.fill = TRUE,
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour2(aes(z = qv-qv_prep$qv), color = "black", size = 0.1, binwidth = 0.00005,
                breaks = AnchorBreaks(0, exclude = 0)) +
  geom_path(data = map, aes(group = group), color = "grey20", size = 0.3) +
  scale_fill_divergent(name = "ANA-BK", 
                       guide = guide_colorbar(barwidth = 10, 
                                              barheight = 0.5, 
                                              breaks = seq(-1e3, 1e3, 2e4))) +
  scale_x_continuous(name = "Lon", limits = c(-67, -56), expand = c(0,0)) +
  scale_y_continuous(name = "Lat", limits = c(-37, -25), expand = c(0,0)) +
  ggtitle("Humedad específica") +
  coord_map() +
  theme_minimal() +
  theme(legend.position="bottom",
        legend.title.align = 0.5,
        legend.margin=margin(t=-0.3, r=0, b=0, l=0, unit="cm"),
        legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 8),
        panel.ontop = TRUE)


ggplot(spd_obs, aes(lon, lat)) +
  geom_contour_fill(aes(z = umet-spd_prep$u), na.fill = TRUE,
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour2(aes(z = umet-spd_prep$u), color = "black", size = 0.1, binwidth = 1,
                breaks = AnchorBreaks(0, exclude = 0)) +
  geom_path(data = map, aes(group = group), color = "grey20", size = 0.3) +
  scale_fill_divergent(name = "ANA-BK", 
                       guide = guide_colorbar(barwidth = 10, 
                                              barheight = 0.5, 
                                              breaks = seq(-1e3, 1e3, 2e4))) +
  scale_x_continuous(name = "Lon", limits = c(-67, -56), expand = c(0,0)) +
  scale_y_continuous(name = "Lat", limits = c(-37, -25), expand = c(0,0)) +
  ggtitle("Velocidad del viento") +
  coord_map() +
  theme_minimal() +
  theme(legend.position="bottom",
        legend.title.align = 0.5,
        legend.margin=margin(t=-0.3, r=0, b=0, l=0, unit="cm"),
        legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 8),
        panel.ontop = TRUE)
