require "language/node"

class Whistle < Formula
  desc "HTTP, HTTP2, HTTPS, Websocket debugging proxy"
  homepage "https://github.com/avwo/whistle"
  url "https://registry.npmjs.org/whistle/-/whistle-2.5.5.tgz"
  sha256 "dd5a0ea8278403952ff761d423b79658b479d212f72b33eda4f2562dbd5b8c9d"

  bottle do
    cellar :any_skip_relocation
    sha256 "fe48e32edd99a50bfc72a4f049bbc33c325ab9fe89f540ea06044c00649f49a0" => :catalina
    sha256 "5a0b8e5209306d72d321539407b8f84be9bf003a94f8ceff7df8266c8608a5e8" => :mojave
    sha256 "6a30134a14efdeb3d387c46cb81893efeeaf4374757d20c99a39b8c579fb04ac" => :high_sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"package.json").write('{"name": "test"}')
    system bin/"whistle", "start"
    system bin/"whistle", "stop"
  end
end
