insert into CAMERAMODEL
(cameramodel_id, manufacturer_id, model, mount_id, format_id, focus_type_id, metering, coupled_metering, metering_type_id, body_type_id, weight, introduced, discontinued, negative_size_id, shutter_type_id, shutter_model, cable_release, viewfinder_coverage, power_drive, continuous_fps, video, digital, fixed_mount, lens_id, battery_qty, battery_type, notes, min_shutter, max_shutter, bulb, time, min_iso, max_iso, af_points, int_flash, int_flash_gn, ext_flash, flash_metering, pc_sync, hotshoe, coldshoe, x_sync, meter_min_ev, meter_max_ev, dof_preview, tripod)
select
camera_id, manufacturer_id, model, mount_id, format_id, focus_type_id, metering, coupled_metering, metering_type_id, body_type_id, weight, introduced, discontinued, negative_size_id, shutter_type_id, shutter_model, cable_release, viewfinder_coverage, power_drive, continuous_fps, video, digital, fixed_mount, lens_id, battery_qty, battery_type, notes, min_shutter, max_shutter, bulb, time, min_iso, max_iso, af_points, int_flash, int_flash_gn, ext_flash, flash_metering, pc_sync, hotshoe, coldshoe, x_sync, meter_min_ev, meter_max_ev, dof_preview, tripod
from CAMERA;