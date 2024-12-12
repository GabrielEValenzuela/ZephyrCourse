#include <zephyr.h>
#include <sys/printk.h>

void check_board() {
#ifdef CONFIG_BOARD
    printk("CONFIG_BOARD is set to your host board.\n");
#else
    printk("CONFIG_BOARD does not correspond to your host board.\n");
#endif
}

void main() {
    printk("Zephyr Application with Star Topology\n");
    check_board();
}
