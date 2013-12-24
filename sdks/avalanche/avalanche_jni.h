/* For when compiling with JNI=1 */
#include <jni.h>

#ifndef _Included_Avalanche
#define _Included_Avalanche
#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT void JNICALL Java_avalanche_Game_launch
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
