class GrpcAT12 < Formula
  desc "Next generation open source RPC library and framework"
  homepage "http://www.grpc.io/"
  url "https://github.com/grpc/grpc/archive/v1.2.5.tar.gz"
  sha256 "44b60a7d2d6108ee569f970373401b57486146bc980bf4dd8187ed052e95cb83"
  head "https://github.com/grpc/grpc.git"
  revision 2

  depends_on "openssl"
  depends_on "pkg-config" => :build
  depends_on "zmap/formula/protobuf@3.2"

  def install
    system "make", "install", "prefix=#{prefix}"

    system "make", "install-plugins", "prefix=#{prefix}"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <grpc/grpc.h>
      int main() {
        grpc_init();
        grpc_shutdown();
        return GRPC_STATUS_OK;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-lgrpc", "-o", "test"
    system "./test"
  end
end
