#include <stdio.h>
#include "vga_fb.h”
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#define X_OFFSET 207
#define Y_OFFSET 127

int vga_fb_fd;
int top_nn_fd;

typedef struct rgb {
	unsigned short r;
	unsigned short g;
	unsigned short b;
}

void write_pixels(const rgb image[50176])
{
  vga_fb_arg_t vla;
  int i;
  for (i = 0 ; i < 50176 ; i++) {
    vla.pixel = X_OFFSET + i%224 + (Y_OFFSET + i/224)*640;
    unsigned int color = image[i].b << 17;
    color += image[i].g << 9;
    color += image[i].r << 1;
    if (i == 50176)  color |= 1;
    vla.colors = color;
    if (ioctl(vga_fb_fd, VGA_FB_WRITE_DIGIT, &vla)) {
      perror("ioctl(VGA_FB_WRITE_DIGIT) failed");
      return;
    }
  }
}

void send_instructions(const int data, unsigned int startaddr,
			unsigned short stride, unsigned short rows,
			unsigned char bid, char pad, char read, char write,
			char reset, char enable, char aid, unsigned short block_num,
			unsigned int subindex, char subblock, char reverse){
  top_nn_arg_t tna;
  tna.startaddr = startaddr;
  tna.data = data; 
  tna.stride = stride;
  tna.rows = rows;
  tna.bid = bid;
  tna.options = ((pad << 3) | (read << 2) | (write < 1) | reset);
  tna.aid  = ((enable << 3) | aid);
  tna.block_num; = block_num;
  tna.subindex = subindex;
  tna.aoptions = ((subblock << 1) | reverse);
  ioctl(top_nn_fd, TOP_NN_WRITE_DIGIT, &tna);
}

void image_on_device(int addr, unsigned short buff[50176]){
  top_nn_arg_t tna;
  int i;
  for (i = 0 ; i < 50176 ; i++) {
    tna.startaddr = addr + (i%4); //need to figure out address
    if (ioctl(top_nn_fd, TOP_NN_READ_DIGIT, &tna)) {
      perror("ioctl(TOP_NN_READ_DIGIT) failed");
      return;
    }
    buff[i] = (tna.data >> 16);
  }
}

int main(){
  vga_fb_arg_t vla;
  top_nn_arg_t tna;

  static const char vganame[] = "/dev/vga_fb”;
  static const char topname[] = "/dev/top_nn”;

  printf(“Neural Network Userspace program started\n");

  if ( (vga_fb_fd = open(vganame, O_RDWR)) == -1) {
    fprintf(stderr, "could not open %s\n", vganame);
    return -1;
  }

  if ( (top_nn_fd = open(topname, O_RDWR)) == -1) {
    fprintf(stderr, "could not open %s\n", topname);
    return -1;
  }
}