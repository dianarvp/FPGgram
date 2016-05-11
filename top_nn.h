#ifndef _top_nn_H
#define _top_nn_H

#include <linux/ioctl.h>

#define top_nn_DIGITS 8

typedef struct {
  unsigned int startaddr;    /* 0, 1, .. , top_nn_DIGITS - 1 */
  unsigned int data; /* LSB is segment a, MSB is decimal point */
  unsigned short stride;
  unsigned short rows;
  unsigned char bid;
  unsigned char options; /*pad-read-write-rest*/
  unsigned char aid  /*enable-operation id*/
  unsigned short block_num;
  unsigned int subindex;
  unsigned char aoptions;
} top_nn_arg_t;

#define TOP_NN_MAGIC ‘k’

/* ioctls and their arguments */
#define TOP_NN_WRITE_DIGIT _IOW(TOP_NN_MAGIC, 1, top_nn_arg_t *)
#define TOP_NN_READ_DIGIT  _IOWR(TOP_NN_MAGIC, 2, top_nn_arg_t *)

#endif
