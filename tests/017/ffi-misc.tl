(load "../common")

(defvarl ar (ffi (array char)))

(defvarl zar (ffi (zarray char)))

(test (ffi-put "\x1234@@@" ar) #b'e188b4404040')

(test (ffi-put "\x1234@@@" zar) #b'e188b440404000')

(test (ffi-get (ffi-put "\x1234@@@" zar) zar) "\x1234@@@")

(unless (meq (os-symbol) :cygwin :cygnal)
  (test (ffi-get #b'EDB08100' (ffi (zarray char)))
       "\xDCED\xDCB0\xDC81")

  (test (ffi-get #b'ED7F7FEDFF00' (ffi (zarray char)))
       "\xDCED\x7F\x7F\xDCED\xDCFF"))

(mtest
  (typeof (ffi (enum a))) ffi-type
  (typeof (ffi (enum b b0 b1 b2 (b3 -15)))) ffi-type
  (typeof (ffi (enum c (c0 (expt 2 512))))) :error
  (typeof (ffi (enum d d0 d0))) :error
  (typeof (ffi (enum e (e0 0) (e0 1)))) :error)

(mtest
  (typeof (ffi (enumed uint16 m))) ffi-type
  (typeof (ffi (enumed uint16 n n0 n1 n2 (n3 15)))) ffi-type
  (typeof (ffi (enumed uint16 o (o0 (expt 2 512))))) :error
  (typeof (ffi (enumed uint16 p p0 p0))) :error
  (typeof (ffi (enumed uint16 q (q0 0) (q0 1)))) :error)

(mtest
  (typeof (ffi (enumed uint8 e (x 0) (y #xff)))) ffi-type
  (typeof (ffi (enumed uint8 e (x -1)))) :error
  (typeof (ffi (enumed uint8 e (x #x100)))) :error)

(mtest
  (typeof (ffi (enumed uint16 e (x 0) (y #xffff)))) ffi-type
  (typeof (ffi (enumed uint16 e (x -1)))) :error
  (typeof (ffi (enumed uint16 e (x #x10000)))) :error)

(mtest
  (typeof (ffi (enumed uint32 e (x 0) (y #xffffffff)))) ffi-type
  (typeof (ffi (enumed uint32 e (x -1)))) :error
  (typeof (ffi (enumed uint32 e (x #x100000000)))) :error)

(mtest
  (typeof (ffi (enumed uint64 e (x 0) (y #xffffffffffffffff)))) ffi-type
  ;(typeof (ffi (enumed uint64 e (x -1)))) #:error
  (typeof (ffi (enumed uint64 e (x #x10000000000000000)))) :error)

(mtest
  (typeof (ffi (enumed int8 e (x 0) (y #x7f)))) ffi-type
  (typeof (ffi (enumed int8 e (x #x-81)))) :error
  (typeof (ffi (enumed int8 e (x #x800)))) :error)

(mtest
  (typeof (ffi (enumed int16 e (x 0) (y #x7fff)))) ffi-type
  (typeof (ffi (enumed int16 e (x #x-8001)))) :error
  (typeof (ffi (enumed int16 e (x #x8000)))) :error)

(mtest
  (typeof (ffi (enumed int32 e (x 0) (y #x7fffffff)))) ffi-type
  (typeof (ffi (enumed int32 e (x #x-80000001)))) :error
  (typeof (ffi (enumed int32 e (x #x80000000)))) :error)

(mtest
  (typeof (ffi (enumed int64 e (x 0) (y #x7fffffffffffffff)))) ffi-type
  (typeof (ffi (enumed int64 e (x #x-8000000000000001)))) :error
  (typeof (ffi (enumed int64 e (x #x8000000000000000)))) :error)
