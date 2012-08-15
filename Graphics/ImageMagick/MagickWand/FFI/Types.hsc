{-# LANGUAGE CPP, ForeignFunctionInterface, NoMonomorphismRestriction, RankNTypes #-}

module Graphics.ImageMagick.MagickWand.FFI.Types
  where

#include <wand/MagickWand.h>

import Control.Monad

import Foreign
import Foreign.C.Types
import Graphics.ImageMagick.MagickCore.Types.FFI.Types

data PixelIterator
data MagickWand
data PixelWand
data DrawingWand
data Image
data PointInfo = PointInfo {piX, piY :: CDouble}
               deriving (Eq, Show)

instance Storable PointInfo where
  sizeOf = const #size PointInfo
  alignment _ = 1
  poke p foo  = do
    #{poke PointInfo, x} p $ piX foo
    #{poke PointInfo, y} p $ piY foo

  peek p = return PointInfo
              `ap` (#{peek PointInfo, x} p)
              `ap` (#{peek PointInfo, y} p)

newtype AlphaChannelType = AlphaChannelType { unAlphaChannelType :: CInt }
  deriving (Eq, Show)

#{enum AlphaChannelType, AlphaChannelType
  , undefinedAlphaChannel = UndefinedAlphaChannel
  , activateAlphaChannel = ActivateAlphaChannel
  , backgroundAlphaChannel = BackgroundAlphaChannel
  , copyAlphaChannel = CopyAlphaChannel
  , deactivateAlphaChannel = DeactivateAlphaChannel
  , extractAlphaChannel = ExtractAlphaChannel
  , opaqueAlphaChannel = OpaqueAlphaChannel
  , resetAlphaChannel = ResetAlphaChannel  /* deprecated */
  , setAlphaChannel = SetAlphaChannel
  , shapeAlphaChannel = ShapeAlphaChannel
  , transparentAlphaChannel = TransparentAlphaChannel
  , lattenAlphaChannel = FlattenAlphaChannel
  , removeAlphaChannel = RemoveAlphaChannel
}

newtype FilterTypes = FilterTypes { unPCREOption :: CInt }
    deriving (Eq,Show)

#{enum FilterTypes, FilterTypes
  , undefinedFilter = UndefinedFilter
  , pointFilter     = PointFilter
  , boxFilter       = BoxFilter
  , triangleFilter  = TriangleFilter
  , hermiteFilter   = HermiteFilter
  , hanningFilter   = HanningFilter
  , hammingFilter   = HammingFilter
  , blackmanFilter  = BlackmanFilter
  , gaussianFilter  = GaussianFilter
  , qaudraticFilter = QuadraticFilter
  , cubicFilter     = CubicFilter
  , catromFilter    = CatromFilter
  , mirchellFilter  = MitchellFilter
  , jincFilter      = JincFilter
  , sinkFilter      = SincFilter
  , sinkFastFilter  = SincFastFilter
  , kaiserFilter    = KaiserFilter
  , welshFilter     = WelshFilter
  , parzenFilter    = ParzenFilter
  , bohmanFilter    = BohmanFilter
  , bartlettFilter  = BartlettFilter
  , lagrangeFilter  = LagrangeFilter
  , lanczosFilter   = LanczosFilter
  , lanczosSharpFilter = LanczosSharpFilter
  , lanczos2Filter  = Lanczos2Filter
  , lanczos2SharpFilter = Lanczos2SharpFilter
  , robidouxFilter  = RobidouxFilter
}

newtype MagickBooleanType = MagickBooleanType { unMagickBooleanType :: CInt}
  deriving (Eq, Show)

#{enum MagickBooleanType, MagickBooleanType 
  , mFalse = MagickFalse
  , mTrue  = MagickTrue
}

newtype ClassType = ClassType { unClassType :: CInt}
  deriving (Eq, Show)

#{enum ClassType, ClassType
  , undefinedClass = UndefinedClass
  , directClass    = DirectClass
  , pseudoClass    = PseudoClass
}

newtype LineCap = LineCap { unLineCap :: CInt }
#{enum LineCap, LineCap
  , udefinedCap = UndefinedCap
  , buttCap = ButtCap
  , roundCap = RoundCap
  , squareCap = SquareCap
}

newtype LineJoin = LineJoin { unLineJoin :: CInt }
#{enum LineJoin, LineJoin
  , undefinedJoin = UndefinedJoin
  , mitterJoin = MiterJoin
  , roundJoin = RoundJoin
  , bevelJoin = BevelJoin
}

newtype FillRule = FillRule { unFillRule :: CInt }
#{enum FillRule, FillRule
 , undefinedRule = UndefinedRule
 , evenOddRule = EvenOddRule
 , nonZeroRule = NonZeroRule
}

data MagickPixelPacket 

instance Storable MagickPixelPacket where
  sizeOf = const #size MagickPixelPacket
  alignment _ = 1


getPixelRed   = #peek MagickPixelPacket, red
getPixelGreen = #peek MagickPixelPacket, green
getPixelBlue  = #peek MagickPixelPacket, blue
getPixelIndex = #peek MagickPixelPacket, index
setPixelRed   = #poke MagickPixelPacket, red
setPixelGreen = #poke MagickPixelPacket, green
setPixelBlue  = #poke MagickPixelPacket, blue
setPixelIndex = #poke MagickPixelPacket, index

{-
data MagicPixelPacket = MagickPixelPacket 
  { storageClass :: ClassType
  , colorspace   :: ColorspaceType
  , matte        :: MagickBooleanType
  , fuzz         :: Double
  , depth        :: CSize
  , red          :: MagickRealType
  , green        :: MagickRealType
  , blue         :: MagickRealType
  , opacity      :: MagickRealType
  , index        :: MagickRealType
  }
  -}
