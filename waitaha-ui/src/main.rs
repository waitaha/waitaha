use std::time::Duration;

use battery::Battery;
use deviceinfo::DeviceInfoConfig;
use slint::{Timer, TimerMode};
use time::{format_description, OffsetDateTime, UtcOffset};

mod battery;
mod deviceinfo;

slint::include_modules!();

fn main() -> Result<(), slint::PlatformError> {
    let deviceinfo = DeviceInfoConfig::load().expect("Failed to parse /etc/deviceinfo");

    let app = MainWindow::new()?;

    let battery = Battery::find()
        .expect("Failed to open battery information")
        .expect("A battery is required");
    let time_fmt = format_description::parse("[hour]:[minute]").unwrap();
    let local_offset = UtcOffset::current_local_offset().expect("Could not get local offset");

    {
        let app_device_info = app.global::<DeviceInfo>();
        app_device_info.set_corner_radius(deviceinfo.corner_radius as i32);
        app_device_info.set_notch_info(NotchInfo {
            height: deviceinfo.notch_height,
            position: deviceinfo.notch_location,
            width: deviceinfo.notch_width,
        });
        app_device_info.set_name(deviceinfo.name.into());
        app_device_info.set_codename(deviceinfo.codename.into());
        app_device_info.set_manufacturer(deviceinfo.manufacturer.into());
    }

    let update_timer = Timer::default();
    update_timer.start(TimerMode::Repeated, Duration::from_secs(1), {
        let weak_app = app.as_weak();

        move || {
            let time = OffsetDateTime::now_utc().to_offset(local_offset);
            let time_fmt = time.format(&time_fmt).unwrap();

            let app_copy = weak_app.unwrap();
            let app_device_info = app_copy.global::<DeviceInfo>();

            app_device_info.set_time(time_fmt.into());
            app_device_info.set_battery_percentage(battery.capacity().unwrap() as i32);
        }
    });

    app.run()
}
