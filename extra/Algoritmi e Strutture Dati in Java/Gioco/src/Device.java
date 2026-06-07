import java.util.Objects;
import java.util.Queue;

public class Device {
    private String mac_address;
    private String ip_address;

    public Device(String mac_address, String ip_address) {
        this.mac_address = mac_address;
        this.ip_address = ip_address;
    }

    public String getMac_address() {
        return mac_address;
    }
    public void setMac_address(String mac_address) {
        this.mac_address = mac_address;
    }
    public String getIp_address() {
        return ip_address;
    }
    public void setIp_address(String ip_address) {
        this.ip_address = ip_address;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Device device = (Device) o;
        return Objects.equals(ip_address, device.ip_address);
    }

}
