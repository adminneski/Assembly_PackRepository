
{******************************************}
{                                          }
{             FastReport VCL               }
{             SVG Components               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
unit frSVGComponents;

interface

{$I frVer.inc}

//uses

type
  TSVGSpecificWord = (
    frx_noMater, frx_RGBA, frx_URI,
    css_font,
    svg_align, svg_alphabetic, svg_arcs, svg_auto,
    svg_bevel, svg_bold, svg_bolder, svg_butt,
    svg_catch_all, svg_central, svg_collapse, svg_context_fill, svg_context_stroke, svg_currentcolor,
    svg_end, svg_evenodd, svg_exact,
    svg_hanging, svg_hidden,
    svg_ideographic, svg_inherit, svg_italic,
    svg_left, svg_lighter, svg_line_through,
    svg_mathematical, svg_meet, svg_middle, svg_miter, svg_miter_clip,
    svg_no_change, svg_none, svg_nonzero, svg_normal,
    svg_objectBoundingBox, svg_oblique, svg_overline,
    svg_pad,
    svg_reflect, svg_repeat, svg_reset_size, svg_right, svg_round,
    svg_slice, svg_square, svg_start, svg_stretch,
    svg_text_after_edge, svg_text_before_edge, svg_text_bottom, svg_text_top, svg_transparent,
    svg_underline, svg_use_script, svg_userSpaceOnUse,
    svg_visible,
    svg_xMinYMin, svg_xMinYMid, svg_xMinYMax, svg_xMidYMin, svg_xMidYMid, svg_xMidYMax, svg_xMaxYMin, svg_xMaxYMid, svg_xMaxYMax
    );

   TSVGSpecificWordSet = set of TSVGSpecificWord;

function IsInSWSet(S: string; SWSet: TSVGSpecificWordSet): boolean;

const
  SVGSpecificWord: array[TSVGSpecificWord] of string = (
    '', '', '',
    'font',
    'align', 'alphabetic', 'arcs', 'auto',
    'bevel', 'bold', 'bolder', 'butt',
    'catch-all', 'central', 'collapse', 'context-fill', 'context-stroke', 'currentcolor',
    'end', 'evenodd', 'exact',
    'hanging', 'hidden',
    'ideographic', 'inherit', 'italic',
    'left', 'lighter', 'line-through',
    'mathematical', 'meet', 'middle', 'miter', 'miter-clip',
    'no-change', 'none', 'nonzero', 'normal',
    'objectBoundingBox', 'oblique', 'overline',
    'pad',
    'reflect', 'repeat', 'reset-size', 'right', 'round',
    'slice', 'square', 'start', 'stretch',
    'text-after-edge', 'text-before-edge', 'text-bottom', 'text-top', 'transparent',
    'underline', 'use-script', 'userSpaceOnUse',
    'visible',
    'xMinYMin', 'xMinYMid', 'xMinYMax', 'xMidYMin', 'xMidYMid', 'xMidYMax', 'xMaxYMin', 'xMaxYMid', 'xMaxYMax'
    );

type
  TSVGAttribute = (
    at_class,
    at_clip_path,
    at_clip_rule,
    at_clipPathUnits,
    at_color,
    at_cx,
    at_cy,
    at_d,
    at_display,
    at_dominant_baseline,
    at_dx,
    at_dy,
    at_fill,
    at_fill_opacity,
    at_fill_rule,
    at_font_family,
    at_font_size,
    at_font_style,
    at_font_weight,
    at_fr,
    at_fx,
    at_fy,
    at_gradientTransform,
    at_gradientUnits,
    at_height,
    at_href,
    at_id,
    at_method,
    at_offset,
    at_opacity,
    at_path,
    at_patternContentUnits,
    at_patternTransform,
    at_patternUnits,
    at_points,
    at_preserveAspectRatio,
    at_r,
    at_rx,
    at_ry,
    at_side,
    at_spacing,
    at_spreadMethod,
    at_startOffset,
    at_stop_color,
    at_stop_opacity,
    at_stroke,
    at_stroke_dasharray,
    at_stroke_dashoffset,
    at_stroke_linecap,
    at_stroke_linejoin,
    at_stroke_miterlimit,
    at_stroke_opacity,
    at_stroke_width,
    at_style,
    at_systemLanguage,
    at_transform,
    at_text_anchor,
    at_text_decoration,
    at_viewBox,
    at_visibility,
    at_width,
    at_x,
    at_x1,
    at_x2,
    at_y,
    at_y1,
    at_y2
  );

  TSVGAttributeSet = set of TSVGAttribute;

  TSVGElement = (
    el_PathElement,
    el_PlainText,
    el_a,
    el_circle,
    el_clipPath,
    el_defs,
    el_ellipse,
    el_g,
    el_image,
    el_line,
    el_linearGradient,
    el_path,
    el_pattern,
    el_polygon,
    el_polyline,
    el_radialGradient,
    el_rect,
    el_stop,
    el_style,
    el_svg,
    el_switch,
    el_text,
    el_textPath,
    el_tspan,
    el_use
    );

  TSVGElementSet = set of TSVGElement;

  TSVGDirection = (sdNo, sdHorizontal, sdVertical, sdDiagonal);
  TSVGDirectionArray = array of TSVGDirection;

  TSVGAttributeData = record
    Name: string;
    Direction: TSVGDirection;
    CSS: TSVGElementSet;
  end;

const
  AnySVGElement = [Low(TSVGElement) .. High(TSVGElement)];

  SVGAttribute: array[TSVGAttribute] of TSVGAttributeData = (
    (Name: 'class';               Direction: sdNo;         CSS: []),
    (Name: 'clip-path';           Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'clip-rule';           Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'clipPathUnits';       Direction: sdNo;         CSS: []),
    (Name: 'color';               Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'cx';                  Direction: sdHorizontal; CSS: [el_circle, el_ellipse]),
    (Name: 'cy';                  Direction: sdVertical;   CSS: [el_circle, el_ellipse]),
    (Name: 'd';                   Direction: sdNo;         CSS: []),
    (Name: 'display';             Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'dominant-baseline';   Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'dx';                  Direction: sdHorizontal; CSS: []),
    (Name: 'dy';                  Direction: sdVertical;   CSS: []),
    (Name: 'fill';                Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'fill-opacity';        Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'fill-rule';           Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'font-family';         Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'font-size';           Direction: sdDiagonal;   CSS: AnySVGElement),
    (Name: 'font-style';          Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'font-weight';         Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'fr';                  Direction: sdDiagonal;   CSS: []),
    (Name: 'fx';                  Direction: sdHorizontal; CSS: []),
    (Name: 'fy';                  Direction: sdVertical;   CSS: []),
    (Name: 'gradientTransform';   Direction: sdNo;         CSS: []),
    (Name: 'gradientUnits';       Direction: sdNo;         CSS: []),
    (Name: 'height';              Direction: sdVertical;   CSS: [el_image, el_rect, el_svg, el_use]),
    (Name: 'href';                Direction: sdNo;         CSS: []),
    (Name: 'id';                  Direction: sdNo;         CSS: []),
    (Name: 'method';              Direction: sdNo;         CSS: []),
    (Name: 'offset';              Direction: sdNo;         CSS: []),
    (Name: 'opacity';             Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'path';                Direction: sdNo;         CSS: []),
    (Name: 'patternContentUnits'; Direction: sdNo;         CSS: []),
    (Name: 'patternTransform';    Direction: sdNo;         CSS: []),
    (Name: 'patternUnits';        Direction: sdNo;         CSS: []),
    (Name: 'points';              Direction: sdNo;         CSS: []),
    (Name: 'preserveAspectRatio'; Direction: sdNo;         CSS: []),
    (Name: 'r';                   Direction: sdDiagonal;   CSS: [el_circle]),
    (Name: 'rx';                  Direction: sdHorizontal; CSS: [el_ellipse, el_rect]),
    (Name: 'ry';                  Direction: sdVertical;   CSS: [el_ellipse, el_rect]),
    (Name: 'side';                Direction: sdNo;         CSS: []),
    (Name: 'spacing';             Direction: sdNo;         CSS: []),
    (Name: 'spreadMethod';        Direction: sdNo;         CSS: []),
    (Name: 'startOffset';         Direction: sdDiagonal;   CSS: []),
    (Name: 'stop-color';          Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'stop-opacity';        Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'stroke';              Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'stroke-dasharray';    Direction: sdDiagonal;   CSS: AnySVGElement),
    (Name: 'stroke-dashoffset';   Direction: sdDiagonal;   CSS: AnySVGElement),
    (Name: 'stroke-linecap';      Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'stroke-linejoin';     Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'stroke-miterlimit';   Direction: sdDiagonal;   CSS: AnySVGElement),
    (Name: 'stroke-opacity';      Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'stroke-width';        Direction: sdDiagonal;   CSS: AnySVGElement),
    (Name: 'style';               Direction: sdNo;         CSS: []),
    (Name: 'systemLanguage';      Direction: sdNo;         CSS: []),
    (Name: 'transform';           Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'text-anchor';         Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'text-decoration';     Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'viewBox';             Direction: sdNo;         CSS: []),
    (Name: 'visibility';          Direction: sdNo;         CSS: AnySVGElement),
    (Name: 'width';               Direction: sdHorizontal; CSS: [el_image, el_rect, el_svg, el_use]),
    (Name: 'x';                   Direction: sdHorizontal; CSS: [el_image, el_rect, el_svg, el_use]),
    (Name: 'x1';                  Direction: sdHorizontal; CSS: []),
    (Name: 'x2';                  Direction: sdHorizontal; CSS: []),
    (Name: 'y';                   Direction: sdVertical;   CSS: [el_image, el_rect, el_svg, el_use]),
    (Name: 'y1';                  Direction: sdVertical;   CSS: []),
    (Name: 'y2';                  Direction: sdVertical;   CSS: [])
  );

  BaseAttributes: TSVGAttributeSet = [
    at_clip_path,
    at_clip_rule,
    at_color,
    at_display,
    at_font_family,
    at_font_size,
    at_font_style,
    at_font_weight,
    at_fill,
    at_fill_opacity,
    at_fill_rule,
    at_opacity,
    at_stroke,
    at_stroke_dasharray,
    at_stroke_dashoffset,
    at_stroke_linecap,
    at_stroke_linejoin,
    at_stroke_miterlimit,
    at_stroke_opacity,
    at_stroke_width,
    at_transform,
    at_text_anchor,
    at_text_decoration,
    at_visibility];

type
  TSVGElementOptions = (eoHaveChild, eoSelfBounds, eoChildBounds, eoPaint, eoMatrix, eoBaseSet);
  TSVGElementOptionsSet = set of TSVGElementOptions;

  TSVGElementData = record
    Name: string;
    Options: TSVGElementOptionsSet;
    Attributes: TSVGAttributeSet;
  end;

const
  SVGElement: array[TSVGElement] of TSVGElementData = (
    (Name: '#pathelement';   Options: [];
      Attributes: []),
    (Name: '#text';          Options: [];
      Attributes: []),
    (Name: 'a';              Options: [eoHaveChild              , eoChildBounds, eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_href,
                   at_systemLanguage]),
    (Name: 'circle';         Options: [             eoSelfBounds               , eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_cx,
                   at_cy,
                   at_r,
                   at_systemLanguage]),
    (Name: 'clipPath';       Options: [eoHaveChild                                      , eoMatrix, eoBaseSet];
      Attributes: [at_clipPathUnits,
                   at_systemLanguage]),
    (Name: 'defs';           Options: [eoHaveChild                                      , eoMatrix, eoBaseSet];
      Attributes: [at_systemLanguage]),
    (Name: 'ellipse';        Options: [             eoSelfBounds               , eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_cx,
                   at_cy,
                   at_rx,
                   at_ry,
                   at_systemLanguage]),
    (Name: 'g';              Options: [eoHaveChild              , eoChildBounds, eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_systemLanguage]),
    (Name: 'image';          Options: [             eoSelfBounds               , eoPaint, eoMatrix           ];
      Attributes: [at_clip_path,
                   at_display,
                   at_height,
                   at_href,
                   at_opacity,
                   at_preserveAspectRatio,
                   at_systemLanguage,
                   at_transform,
                   at_visibility,
                   at_width,
                   at_x,
                   at_y]),
    (Name: 'line';           Options: [             eoSelfBounds               , eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_systemLanguage,
                   at_x1,
                   at_y1,
                   at_x2,
                   at_y2]),
    (Name: 'linearGradient'; Options: [eoHaveChild                                      , eoMatrix, eoBaseSet];
      Attributes: [at_gradientTransform,
                   at_gradientUnits,
                   at_href,
                   at_spreadMethod,
                   at_x1,
                   at_y1,
                   at_x2,
                   at_y2]),
    (Name: 'path';           Options: [             eoSelfBounds               , eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_d,
                   at_systemLanguage]),
    (Name: 'pattern';        Options: [eoHaveChild                                                , eoBaseSet];
      Attributes: [at_height,
                   at_href,
                   at_patternContentUnits,
                   at_patternTransform,
                   at_patternUnits,
                   at_preserveAspectRatio,
                   at_systemLanguage,
                   at_viewBox,
                   at_width,
                   at_x,
                   at_y]),
    (Name: 'polygon';        Options: [             eoSelfBounds               , eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_points,
                   at_systemLanguage]),
    (Name: 'polyline';       Options: [             eoSelfBounds               , eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_points,
                   at_systemLanguage]),
    (Name: 'radialGradient'; Options: [eoHaveChild                                      , eoMatrix, eoBaseSet];
      Attributes: [at_cx,
                   at_cy,
                   at_fr,
                   at_fx,
                   at_fy,
                   at_gradientTransform,
                   at_gradientUnits,
                   at_href,
                   at_spreadMethod,
                   at_r]),
    (Name: 'rect';           Options: [             eoSelfBounds               , eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_height,
                   at_rx,
                   at_ry,
                   at_systemLanguage,
                   at_x,
                   at_y,
                   at_width]),
    (Name: 'stop';           Options: [];
      Attributes: [at_color,
                   at_offset,
                   at_stop_color,
                   at_stop_opacity]),
    (Name: 'style';          Options: [];
      Attributes: []),
    (Name: 'svg';            Options: [eoHaveChild, eoSelfBounds               , eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_height,
                   at_preserveAspectRatio,
                   at_systemLanguage,
                   at_x,
                   at_y,
                   at_viewBox,
                   at_width]),
    (Name: 'switch';         Options: [eoHaveChild              , eoChildBounds, eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_systemLanguage]),
    (Name: 'text';           Options: [eoHaveChild, eoSelfBounds, eoChildBounds, eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_dominant_baseline,
                   at_dx,
                   at_dy,
                   at_systemLanguage,
                   at_x,
                   at_y]),
    (Name: 'textPath';       Options: [eoHaveChild, eoSelfBounds, eoChildBounds, eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_dominant_baseline,
                   at_href,
                   at_startOffset,
                   at_systemLanguage]),
    (Name: 'tspan';          Options: [eoHaveChild, eoSelfBounds, eoChildBounds, eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_dominant_baseline,
                   at_dx,
                   at_dy,
                   at_systemLanguage,
                   at_x,
                   at_y]),
    (Name: 'use';            Options: [                           eoChildBounds, eoPaint, eoMatrix, eoBaseSet];
      Attributes: [at_height,
                   at_href,
                   at_systemLanguage,
                   at_x,
                   at_y,
                   at_width])
    );

implementation

//uses

function IsInSWSet(S: string; SWSet: TSVGSpecificWordSet): boolean;
var
  sw: TSVGSpecificWord;
begin
  Result := False;
  if S <> '' then
    for sw := Low(sw) to High(sw) do
      if S = SVGSpecificWord[sw] then
      begin
        Result := True;
        Break;
      end;
end;

end.
