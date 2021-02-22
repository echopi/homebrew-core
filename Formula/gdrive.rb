class Gdrive < Formula
  desc "Google Drive CLI Client"
  homepage "https://github.com/gdrive-org/gdrive"
  url "https://github.com/gdrive-org/gdrive/archive/2.1.0.tar.gz"
  sha256 "a1ea624e913e258596ea6340c8818a90c21962b0a75cf005e49a0f72f2077b2e"
  license "MIT"
  head "https://github.com/gdrive-org/gdrive.git"

  bottle do
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4e4e3ac736173da5aaa2106ad3eb505cbb83e68f8a78b19a8b10c7bf2de50b3b"
    sha256 cellar: :any_skip_relocation, big_sur:       "0a22953fde6b318c5a658b639176d3bb445e8cd162cd1c28cebbb3984d652227"
    sha256 cellar: :any_skip_relocation, catalina:      "c89785f7d95e16fe113f649f47c80261ce7d335427d60c6543a3bd8d58eee522"
    sha256 cellar: :any_skip_relocation, mojave:        "e26ef4bec660913f42aa735c28f58393912d2d0293bf98a351fa2b27a1baee01"
    sha256 cellar: :any_skip_relocation, high_sierra:   "8fc5917762cd0b7622d35053931b41315606be97ba38ae34c9a67bf7ff87a1d3"
    sha256 cellar: :any_skip_relocation, sierra:        "b03e82ba9bb723b7f6225607b3127b9d515f0d79271f76b375b74324aecfb057"
  end

  # See https://github.com/prasmussen/gdrive/commit/31d0829c180795d17e00b7a354fffe4d72be712b
  deprecate! date: "2021-02-18", because: :unmaintained

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    dir = buildpath/"src/github.com/prasmussen/gdrive"
    dir.install buildpath.children
    dir.cd do
      system "go", "build", "-o", bin/"gdrive", "."
      doc.install "README.md"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gdrive version")
  end
end
