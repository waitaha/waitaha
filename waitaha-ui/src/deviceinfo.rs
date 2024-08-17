use std::{fs::read_to_string, str::FromStr};

use super::NotchPosition;

/// Device info parsing error.
#[derive(Debug)]
pub enum Error {
    /// Unknown cutout shape.
    UnknownCutout,
    /// Integer expected.
    ExpectedInt,
    /// Invalid option.
    InvalidOption(String),
    /// Error reading config file.
    Io,
}

/// Information about the device.
#[derive(Debug, Default)]
pub struct DeviceInfoConfig {
    /// Camera cutout location.
    pub notch_location: NotchPosition,
    /// Camera cutout width in pixels.
    pub notch_width: i32,
    /// Camera cutout height in pixels.
    pub notch_height: i32,
    /// Rounded corner radius in pixels.
    pub corner_radius: u8,
    /// Device name.
    pub name: String,
    /// Device codename.
    pub codename: String,
    /// Device manufacturer.
    pub manufacturer: String,
}

impl DeviceInfoConfig {
    pub fn load() -> Result<Self, Error> {
        let contents = read_to_string("/etc/deviceinfo").map_err(|_| Error::Io)?;

        Self::from_str(&contents)
    }
}

impl FromStr for DeviceInfoConfig {
    type Err = Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let mut info = Self::default();

        for option in s.split(',') {
            let parts = option.split_once('=');

            match parts {
                // key=value
                Some((key, value)) => match key {
                    "notch_location" => info.notch_location = NotchPosition::from_str(value)?,
                    "notch_width" => {
                        info.notch_width = value.parse().map_err(|_| Error::ExpectedInt)?
                    }
                    "notch_height" => {
                        info.notch_height = value.parse().map_err(|_| Error::ExpectedInt)?
                    }
                    "corner_radius" => {
                        info.corner_radius = value.parse().map_err(|_| Error::ExpectedInt)?
                    }
                    "name" => info.name = value.to_string(),
                    "codename" => info.codename = value.to_string(),
                    "manufacturer" => info.manufacturer = value.to_string(),
                    _ => return Err(Error::InvalidOption(key.to_string())),
                },
                // flag
                None => match option {
                    _ => return Err(Error::InvalidOption(option.to_string())),
                },
            }
        }

        Ok(info)
    }
}

impl FromStr for NotchPosition {
    type Err = Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "none" => Ok(Self::None),
            "left" => Ok(Self::Left),
            "center" | "middle" => Ok(Self::Middle),
            "right" => Ok(Self::Right),
            _ => Err(Error::UnknownCutout),
        }
    }
}
