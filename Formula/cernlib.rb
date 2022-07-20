class cernlib < Formula
  desc "Cernlib"
  homepage "https://hepmc.web.cern.ch/"
  url "https://hepmc.web.cern.ch/hepmc/releases/HepMC3-3.2.5.tar.gz"
  sha256 "cd0f75c80f75549c59cc2a829ece7601c77de97cb2a5ab75790cac8e1d585032"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url "https://hepmc.web.cern.ch/hepmc/"
    regex(/href=.*?cernlib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "coreutils" # HepMC3-config uses greadlink

  def install
    mkdir "../build" do
      args = %W[
        -DCMAKE_INSTALL_PREFIX=#{prefix}
      ]


      system "cmake", buildpath, *args
      system "make"
      system "make", "test" if build.with? "test"
      system "make", "install"
    end
  end


end
