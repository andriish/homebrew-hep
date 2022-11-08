class Cernlib < Formula
  desc "CERN library"
  homepage "https://cernlib.web.cern.ch"
  url "https://cernlib.web.cern.ch/cernlib/download/2022_source/tar/cernlib-2022.11.08.0-free.tar.gz"
  sha256 "733d148415ef78012ff81f21922d3bf641be7514b0242348dd0200cf1b003e46"
  license "GPL-2.0-or-later"
  revision 1

  depends_on "cmake" => [:build]
  depends_on "gcc" => [:build]
  depends_on "coreutils"
  depends_on "libXaw"
  depends_on "openmotif"
  def install
    mkdir "../build" do
      args = %W[
        -S
        ../#{version}/src
        -DCMAKE_CXX_COMPILER=g++-#{Formula["gcc"].version_suffix}
        -DCMAKE_Fortran_COMPILER=gfortran-#{Formula["gcc"].version_suffix}
        -DCMAKE_C_COMPILER=gcc-#{Formula["gcc"].version_suffix}
        -DCMAKE_INSTALL_PREFIX=#{prefix}
        -DMOTIF_INCLUDE_DIR=#{Formula["openmotif"].include}
        -DMOTIF_LIBRARIES=#{Formula["openmotif"].lib}/libXm.dylib
      ]
      system "cmake", "-B", ".", *args
      system "cmake", "--build", "."
      system "cmake", "--install", "."
    end
  end
  test do
    system "ctest", "."
  end
end
