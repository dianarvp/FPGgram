#ifndef _VGA_FB_H
#define _VGA_FB_H

#include <linux/ioctl.h>

#define VGA_PIXELS 307200

typedef struct {
  unsigned int pixel;    /* pixel to write to */
  unsigned int colors; /* rgb value to write to pixel */
} vga_led_arg_t;

#define VGA_FB_MAGIC 'q'

/* ioctls and their arguments */
#define VGA_FB_WRITE_PIXEL _IOW(VGA_FB_MAGIC, 1, vga_fb_arg_t *)
#define VGA_FB_READ_PIXEL  _IOWR(VGA_FB_MAGIC, 2, vga_fb_arg_t *)

#endif
