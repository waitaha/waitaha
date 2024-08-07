use std::{fs, io, path};

const POWERSUPPLY_PATH: &str = "/sys/class/power_supply";

#[derive(Debug)]
pub struct Battery {
    path: path::PathBuf,
}

impl Battery {
    pub fn find() -> io::Result<Option<Self>> {
        let power_supplies = fs::read_dir(POWERSUPPLY_PATH)?;

        for power_supply in power_supplies {
            let entry = power_supply?;
            let supply_type = fs::read_to_string(entry.path().join("type"))?;

            if supply_type.trim() == "Battery" {
                return Ok(Some(Self { path: entry.path() }));
            }
        }

        Ok(None)
    }

    pub fn capacity(&self) -> io::Result<u8> {
        Ok(fs::read_to_string(self.path.join("capacity"))?
            .trim()
            .parse()
            .expect("Capacity is an integer from 0-100"))
    }
}
