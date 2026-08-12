#import "lib.typ": *

#set page(height: auto, width: auto, margin: 0.15cm)

#spheres(
  center-label: [w],
  parabolas: (
    (
      label: $phi^+$,
      angle: 38,
      touch-angle: 45,
      depth: 4,
      label-offset: (0.1, 0.30),
      shade: (4, 5),
    ),
    (
      label: $phi$,
      angle: 41,
      touch-angle: 45,
      depth: 2,
      label-offset: (0.68, 0.23),
      shade: (2, 3),
    ),
    (
      label: $psi$,
      angle: 328,
      touch-angle: 86,
      depth: 3,
      label-position: -1.0,
      label-offset: (0.08, -0.04),
    ),
  ),
)
