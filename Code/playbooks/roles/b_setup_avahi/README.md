# Avahi Daemon

Avahi is a free zero-configuration networking (zeroconf) implementation, including a system for multicast DNS/DNS-SD service discovery.
It is licensed under the GNU Lesser General Public License (LGPL).

Avahi is a system which enables programs to publish and discover services and hosts running on a local network.
For example, a user can plug a computer into a network and have Avahi automatically advertise the network services running on its machine, facilitating user access to those services.

The avahi-daemon Linux service runs on client machines to perform network-based Zeroconf service discovery.
Avahi is an implementation of the DNS Service Discovery and Multicast DNS specifications for Zeroconf Networking.
User applications receive notice of discovered network services and resources using the Linux D-Bus message passing.
The daemon coordinates application efforts in caching replies, helping minimize network traffic.

Avahi provides a set of language bindings, including Python and Mono.
Because of its modularized architecture, Avahi is already integrated into major desktop components like GNOME’s Virtual File System or KDE’s input/output architecture.

Refer http://avahi.org/ for further specifications.
