RSRC                    RDShaderFile            ��������                                                  resource_local_to_scene    resource_name    bytecode_vertex    bytecode_fragment    bytecode_tesselation_control     bytecode_tesselation_evaluation    bytecode_compute    compile_error_vertex    compile_error_fragment "   compile_error_tesselation_control %   compile_error_tesselation_evaluation    compile_error_compute    script 
   _versions    base_error           local://RDShaderSPIRV_ovewp ;         local://RDShaderFile_kwlx4 �I         RDShaderSPIRV          hG  #    �             2        GLSL.std.450                     main    )   r   �   �   �   �     A  S                        �       main         z_compare(f1;f1;f1;   	   a     
   b        sze  
    interleaved_gradient_noise(vf2;      uv       safenorm(vf2;        v        jitter_tile(vf2;         uvi   '   Params    '       motion_blur_samples  	 '      motion_blur_intensity    	 '      motion_blur_center_fade   '      frame    	 '      last_iteration_index     	 '      sample_step_multiplier   	 '      step_exponent_modifier    '      max_dilation_radius   '      nan0      '   	   nan1      '   
   nan2      '      nan3      )   params    6   magic     H   l     \   angle     a   param     f   rx    i   ry    r   tile_max         render_size   �   color_sampler     �   uvi   �   gl_GlobalInvocationID     �   x     �   velocity_map_sample   �   velocity_map      �   param     �   vnz   �   vn_length     �   multiplier    �   vn    �   col_x     �   vxz   �   velocity_sampler      �   vx_length       vx      wx      param       output_image        wvnz        velocity_match    2  wn    3  param     6  zx    :  j     =  param     @  past_vxz      A  past_velocity_sampler     O  past_vx   R  past_col_x    S  past_color_sampler    W  weight    Y  sum   ]  nai_weight    ^  nai_sub_weight    _  nai_sum   c  past_weight   d  past_sub_weight   e  past_sum      i  final_sample_count    m  i     x  t     �  back_t    �  T     �  y     �  nai_T     �  nai_y     �  nai_back_y    �  nai_vy    �  nai_vy_length     �  nai_zy    �  nai_b     �  param     �  param     �  param     �  nai_f     �  param     �  param     �  param     �  nai_wa    �  vy_length     �  nai_ay    �  nai_y_inside        past_y      past_back_y   #  alpha     *  param     +  param     ,  param     .  past_vy   <  past_zy   D  past_b    J  param     K  param     L  param     N  past_ay   ]  past_y_inside     z  vy    �  zy    �  f     �  param     �  param     �  param     �  wa    �  ay_trail      �  y_inside    H  '       #       H  '      #      H  '      #      H  '      #      H  '      #      H  '      #      H  '      #      H  '      #      H  '      #       H  '   	   #   $   H  '   
   #   (   H  '      #   ,   G  '      G  r   "       G  r   !      G  �   "       G  �   !       G  �         G  �   "       G  �   !      G  �   "       G  �   !      G    "       G    !      G       G  A  "       G  A  !      G  S  "       G  S  !      G  �             !                             !                                        !           !           +          �?+     "         &            '                           &   &   &   &      (   	   '   ;  (   )   	   +  &   *         +   	      +     .   ��B+     /   =
=A,     0   .   /     4            5      4   +     7   Cq�=+     8   �E�;+     9   ��SB,  4   :   7   8   9     ;           +  ;   <      +     K   �7�5+     R      ?  S   +  &   U       +  &   V      +     ^      @,     _   ^   "   +     c   �I@ 	 o                              p   o      q       p   ;  q   r         u   &      +     y     �@   ~      u   ;  q   �         �   ;         �      �   ;  �   �        �   ;      +  ;   �          �      &   +  ;   �      ,     �   R   R   ;  q   �         �         +  &   �      +     �     �    �      �   ;  q   �        	                                      ;          +        @F+  ;   7     ;  q   A      ;  q   S      +     X  ��'7+     y    ��+     �   @�F+  ;   �     ,  �   �  �  �  �   6               �     ;  ~         ;  ~   �      ;     �      ;     �      ;     �      ;  5   �      ;     �      ;     �      ;     �      ;  �   �      ;  �   �      ;     �      ;          ;          ;          ;  5        ;          ;     2     ;     3     ;     6     ;     :     ;     =     ;  �   @     ;     O     ;  �   R     ;     W     ;  �   Y     ;     ]     ;     ^     ;  �   _     ;     c     ;     d     ;  �   e     ;     i     ;  �   m     ;     x     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;  �   �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;          ;          ;     #     ;     *     ;     +     ;     ,     ;  �   .     ;     <     ;     D     ;     J     ;     K     ;     L     ;     N     ;     ]     ;  �   z     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     ;     �     =  p   �   �   d  o   �   �   g  u   �   �   U   Q  &   �   �       Q  &   �   �      P  u   �   �   �   >     �   =  �   �   �   O  �   �   �   �          |  u   �   �   >  �   �   A  �   �   �   �   =  &   �   �   A  �   �      �   =  &   �   �   �  S   �   �   �   �  S   �   �   �  �       �  �   �   �   �  �   A  �   �   �   �   =  &   �   �   A  �   �      �   =  &   �   �   �  S   �   �   �   �  �   �  �   �  S   �   �      �   �   �  �       �  �   �   �   �  �   �  �  �   =  u   �   �   o     �   �   �     �   �   �   =  u   �      o     �   �   �     �   �   �   >  �   �   =  p   �   �   =     �   �   =  u   �   �   o     �   �   >  �   �   9     �      �   �     �   �   �   X  �   �   �   �      "   O     �   �   �          >  �   �   =  p   �   r   =     �   �   X  �   �   �   �      "   O  4   �   �   �             =  u   �      o     �   �   Q     �   �       Q     �   �      P  4   �   �   �      �  4   �   �   �   >  �   �   =  4   �   �   O     �   �   �               �      B   �        �      (   R   �   >  �   �   =     �   �   A  +   �   )   �   =     �   �   =     �   �   A  +   �   )   V   =     �   �   �     �   �   �        �      %   �   �        �      +   �   "   �   =     �   �        �      (   �   �   �     �   �   �   >  �   �   =     �   �   =  4   �   �   �  4   �   �   �   >  �   �   =     �   �   =     �   �   �     �   �   �   >  �   �   =  4   �   �   O     �   �   �          >  �   �   =  p   �   �   =     �   �   X  �   �   �   �      "   >  �   �   =  p   �   �   =     �   �   X  �   �   �   �      "   =  u   �      o     �   �   Q     �   �       Q     �   �      P  �   �   �   �         �  �   �   �   �   >  �   �   =  �   �   �   O     �   �   �               �      B   �        �      (   R   �   >  �   �   =     �   �   =  �   �   �   O  4   �   �   �             �  4   �   �   �   A     �   �   �   Q     �   �       >  �   �   A     �   �   �   Q     �   �      >  �   �   A     �   �   <   Q     �   �      >  �   �   =     �   �   =     �   �   �        �   �   >  �      =  �     �   O                  >      =         >      9            >      =       �   �  S   	    R   �        �  	  
    �  
  =        =  u     �   =  �     �   c        �  �    =  4     �     4        E     >      =         =       �   �           =       �   =       �   �           �                     +     "      A        �   <   =     !          "        !       #        "  ^   �     $    #  �     %     $       &          %  >    &  =     '  �   =     (    =     )    P     *  )  )       +     .   '  (  *  >  �   +  =  4   ,  �   =  �   -  �   O  4   .  -  -            =     /    P  4   0  /  /  /    4   1     .   ,  .  0  >  �   1  =     4  �   >  3  4  9     5     3  >  2  5  A     8  �   7  =     9  8  >  6  9  =  u   ;  �   o     <  ;  >  =  <  9     >     =  �     ?  >  R   >  :  ?  =  p   B  A  =     C  �   X  �   D  B  C     "   =  u   E     o     F  E  =     G  �   �     H  F  G  =     I  �   �     J     I  Q     K  H      Q     L  H     P  �   M  K  L  J     �  �   N  D  M  >  @  N  =  �   P  @  O     Q  P  P         >  O  Q  =  p   T  S  =     U  �   X  �   V  T  U     "   >  R  V  >  W  X  =  �   Z  �   =     [  W  �  �   \  Z  [  >  Y  \  >  ]  X  >  ^  X  =  �   `  �   =     a  ^  �  �   b  `  a  >  _  b  >  c  X  >  d  X  =  �   f  R  =     g  d  �  �   h  f  g  >  e  h  A  +   j  )   U   =     k  j  �     l  k  X  >  i  l  >  m  U   �  n  �  n  �  p  q      �  r  �  r  =  &   s  m  o     t  s  A  +   u  )   U   =     v  u  �  S   w  t  v  �  w  o  p  �  o  =  &   z  m  o     {  z  =     |  :  �     }  {  |  �     ~  }     A  +     )   U   =     �    �     �  �     �     �  ~  �       �     .   "   y  �  >  x  �  =  &   �  m  o     �  �  =     �  :  �     �  �  �  �     �  �     A  +   �  )   U   =     �  �  �     �  �     �     �  �  �       �     .      "   �  >  �  �  =     �  x  =     �  �   �     �  �  �       �        �  >  �  �  =     �  �   =     �  �   =  u   �     o     �  �  �     �  �  �  =     �  x  �     �  �  �  �     �  �  �  >  �  �  =     �  x  =     �  �   �     �  �  �       �        �  >  �  �  =     �  �   =     �    =  u   �     o     �  �  �     �  �  �  =     �  x  �     �  �  �  �     �  �  �  >  �  �  =     �  �   =     �    =  u   �     o     �  �  �     �  �  �  =     �  �  �     �  �  �  �     �  �  �  >  �  �  =  p   �  �   =     �  �  X  �   �  �  �     "   =  u   �     o     �  �  =     �  �   �     �  �  �  =     �  �   �     �     �  Q     �  �      Q     �  �     P  �   �  �  �  �     �  �   �  �  �  >  �  �  =  �   �  �  O     �  �  �              �     B   �       �     (   R   �  >  �  �  A     �  �  7  =     �  �  A     �  �   <   =     �  �  =     �  x  �     �  �  �  �     �  �  �  >  �  �  =     �  6       �  �  =     �  �       �  �  >  �  �  >  �  �  >  �  �  9     �     �  �  �  >  �  �  =     �  �       �  �  =     �  6       �  �  >  �  �  >  �  �  >  �  �  9     �     �  �  �  >  �  �  =  �   �  �  O     �  �  �         =     �  �  P     �  �  �  �     �  �  �  =     �    �     �  �  �       �     (   "   �       �        �  >  �  �  =     �  �       �     (   �  "   >  �  �  =     �  ]  �     �  �     >  ]  �  =     �  ^  �     �  �     >  ^  �  A     �  �  �   =     �  �       �     0   "   �  A     �  �  �   =     �  �       �     0   �     �     �  �  �  A     �  �  �   =     �  �       �     0   "   �  �     �  �  �  A        �  �   =                    0        �       �    >  �    =  p     �   =       �  X  �            "   =  p     �   =       �  X  �   	         "   =     
  �  =       �  �       
    P  �               �        .     	    =  �     _  �  �         >  _    =       �   =       O  =  u        o         �           =       x  �           �           >      =       �   =       O  =  u        o         �           =        �  �     !       �     "    !  >    "  A     $  @  7  =     %  $       &  %  A     '  �   7  =     (  '       )  (  >  *  &  >  +  )  >  ,  �  9     -     *  +  ,  >  #  -  =  p   /  A  =     0    X  �   1  /  0     "   =  u   2     o     3  2  =     4  �   �     5  3  4  =     6  �   �     7     6  Q     8  5      Q     9  5     P  �   :  8  9  7     �  �   ;  1  :  >  .  ;  A     =  .  7  =     >  =  A     ?  @  <   =     @  ?  =     A  x  �     B  @  A  �     C  >  B  >  <  C  A     E  @  7  =     F  E       G  F  =     H  <       I  H  >  J  G  >  K  I  >  L  �  9     M     J  K  L  >  D  M  =     O  �  =     P  �  =     Q  �  �     R  P  Q       S     0   O  R  �     T     S  =     U  #  �     V     U  �     W  T  V  >  N  W  =     X  N  =     Y  c  �     Z  Y  X  >  c  Z  =     [  d  �     \  [     >  d  \  A     ^    �   =     _  ^       `     0   "   _  A     a    �   =     b  a       c     0   b     �     d  `  c  A     e    �   =     f  e       g     0   "   f  �     h  d  g  A     i    �   =     j  i       k     0   j     �     l  h  k  >  ]  l  =  p   m  S  =     n    X  �   o  m  n     "   =  p   p  S  =     q    X  �   r  p  q     "   =     s  D  =     t  ]  �     u  s  t  P  �   v  u  u  u  u    �   w     .   o  r  v  =  �   x  e  �  �   y  x  w  >  e  y  =  p   {  �   =     |  �  X  �   }  {  |     "   =  u   ~     o       ~  =     �  �   �     �    �  =     �  �   �     �     �  Q     �  �      Q     �  �     P  �   �  �  �  �     �  �   �  }  �  >  z  �  =  �   �  z  O     �  �  �              �     B   �       �     (   R   �  >  �  �  A     �  z  7  =     �  �  A     �  �   <   =     �  �  =     �  x  �     �  �  �  �     �  �  �  >  �  �  =     �  �       �  �  =     �  6       �  �  >  �  �  >  �  �  >  �  �  9     �     �  �  �  >  �  �  =  �   �  z  O     �  �  �         =     �  �  P     �  �  �  �     �  �  �  =     �  2  �     �  �  �       �     (   "   �       �        �  >  �  �  =     �  �  =     �  �  =     �  �  =     �  �  �     �  �  �       �     0   �  �  �     �  �  �  >  �  �  A     �  �  �   =     �  �       �     0   "   �  A     �  �  �   =     �  �       �     0   �     �     �  �  �  A     �  �  �   =     �  �       �     0   "   �  �     �  �  �  A     �  �  �   =     �  �       �     0   �     �     �  �  �  >  �  �  =     �  �  =     �  �  �     �  �  �  =     �  W  �     �  �  �  >  W  �  =  p   �  �   =     �  �  X  �   �  �  �     "   =     �  �  �  �   �  �  �  =     �  �  �  �   �  �  �  =  �   �  Y  �  �   �  �  �  >  Y  �  �  q  �  q  =  &   �  m  �  &   �  �  V   >  m  �  �  n  �  p  =     �  W  =  �   �  Y  P  �   �  �  �  �  �  �  �   �  �  �  >  Y  �  =     �  i  =     �  W  �     �  �  �  >  W  �  =     �  ^  =  �   �  _  P  �   �  �  �  �  �  �  �   �  �  �  >  _  �  =     �  i  =     �  ]  �     �  �  �  >  ]  �  =     �  d  =  �   �  e  P  �   �  �  �  �  �  �  �   �  �  �  >  e  �  =     �  i  =     �  c  �     �  �  �  >  c  �  =  �   �  _  =  �   �  e  =     �  c  P  �   �  �  �  �  �    �   �     .   �  �  �  =  �   �  Y  =     �  W  P  �   �  �  �  �  �    �   �     .   �  �  �  >  Y  �  =    �    =  u   �  �   =  �   �  Y  c  �  �  �  �  8  6               7     	   7     
   7        �     =           =        	   =        
   �              �               �     !               #      +   !   "      �  #   8  6               7        �     ;  5   6      A  +   ,   )   *   =     -   ,   �     1   0   -   =     2      �     3   2   1   >     3   >  6   :   A     =   6   <   =     >   =   =     ?      =  4   @   6   O     A   @   @          �     B   ?   A        C      
   B   �     D   >   C        E      
   D   �  E   8  6               7        �     ;     H      =     I           J      B   I        L      (   J   K   >  H   L   =     M      =     N   H   P     O   N   N   �     P   M   O   =     Q   H   �  S   T   Q   R   �  &   W   T   V   U   o     X   W   �     Y   P   X   �  Y   8  6               7        �     ;     \      ;     a      ;     f      ;     i      =     ]      �     `   ]   _   >  a   `   9     b      a   �     d   b   c   �     e   d   ^   >  \   e   =     g   \        h         g   >  f   h   =     j   \        k         j   >  i   k   =     l   f   =     m   i   P     n   l   m   =  p   s   r   d  o   t   s   g  u   v   t   U   o     w   v   �     x   n   w   P     z   y   y   �     {   x   z   �  {   8           RDShaderFile                                    RSRC