class Mercury < Formula
  desc "Logic/functional programming language"
  homepage "https://mercurylang.org/"
  url "https://dl.mercurylang.org/release/mercury-srcdist-20.01.1.tar.gz"
  sha256 "579cf00fa485d3918dbf9e50bb8057662b66fb82f69b3b824542e42a814bb76f"

  bottle do
    cellar :any
    sha256 "2beee99d44c44e0d368d2317d08b3a2e0482f9f188cc1037a04664a51b08b605" => :catalina
    sha256 "73f7a5af0479bdabb0bf50366ef2b638a69b42d17ac2de0b597e43f90c28377d" => :mojave
    sha256 "2b68773f1e4dd35bb70ed17a94f82ef7bb4e11f5169869d8904d7f6ce667003a" => :high_sierra
    sha256 "200fbd8b1e59fa3b4b7ef80d09955c697a31e83f15eb4c661bef1dc2458236d0" => :sierra
    sha256 "daf916b14c3358f4d7ed6cdba153f96d6f4acec2d29b9fb43b027a6610bd783d" => :el_capitan
    sha256 "afcff5ed87fdd477ce8037cca2f3fcab828b71cf78e1fbde951c4e17ae3e0b17" => :yosemite
    sha256 "0e736ef6f5cc48bc9d6f7d50cb9df6fb52dba2b0b3bf2d83b378f83fcff4ecb9" => :mavericks
  end

  depends_on "openjdk"

  def install
    args = ["--prefix=#{prefix}",
            "--mandir=#{man}",
            "--infodir=#{info}"]

    system "./configure", *args

    system "make", "install", "PARALLEL=-j"

    # Remove batch files for windows.
    rm Dir.glob("#{bin}/*.bat")
  end

  test do
    test_string = "Hello Homebrew\n"
    path = testpath/"hello.m"
    path.write <<~EOS
      :- module hello.
      :- interface.
      :- import_module io.
      :- pred main(io::di, io::uo) is det.
      :- implementation.
      main(IOState_in, IOState_out) :-
          io.write_string("#{test_string}", IOState_in, IOState_out).
    EOS

    system "#{bin}/mmc", "-o", "hello_c", "hello"
    assert_predicate testpath/"hello_c", :exist?

    assert_equal test_string, shell_output("#{testpath}/hello_c")

    system "#{bin}/mmc", "--grade", "java", "hello"
    assert_predicate testpath/"hello", :exist?

    assert_equal test_string, shell_output("#{testpath}/hello")
  end
end
