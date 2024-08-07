use std::{fs::read_to_string, str::FromStr};

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
    pub display_cutout: Cutout,
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
            println!("part: {option:?}");
            let parts = option.split_once('=');
            println!("parts: {parts:?}");

            match parts {
                // key=value
                Some((key, value)) => match key {
                    "display_cutout" => info.display_cutout = Cutout::from_str(value)?,
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

/// Camera cutout location.
#[derive(Debug, Default)]
pub enum Cutout {
    #[default]
    None,
    Left,
    Center,
    Right,
}

impl FromStr for Cutout {
    type Err = Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "none" => Ok(Self::None),
            "left" => Ok(Self::Left),
            "center" => Ok(Self::Center),
            "right" => Ok(Self::Right),
            _ => Err(Error::UnknownCutout),
        }
    }
}
