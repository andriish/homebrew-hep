class TheP8I < Formula
  desc "ThePEG Interface for Pythia8"
  homepage "https://gitlab.cern.ch/lonnblad/thep8i"
  url "https://gitlab.cern.ch/averbyts/thep8i/-/archive/master/thep8i-master.tar.gz"
  version "0.9.1"
  sha256 "b55876e6ff50e7419e09dd12bb9f3ea33215536ec00bbe6b99fe9d844edcf905"

  depends_on "pythia8"
  depends_on "thepeg"

  def install
    args = %W[
      --prefix=#{prefix}
      --with-pythia8=#{Formula["pythia8"].opt_prefix}
      --with-thepeg=#{Formula["thepeg"].opt_prefix}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    ENV["PYTHIA8DATA"] = share/"Pythia8/xmldoc"
    system "make", "check"
  end
end
