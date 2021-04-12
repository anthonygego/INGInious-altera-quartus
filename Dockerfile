FROM ingi/inginious-c-base
LABEL org.inginious.grading.name="quartus"

# Copy Quartus+ModelSim install files
#ADD QuartusLiteSetup-16.0.0.211-linux.run /tmp/
#ADD ModelSimSetup-16.0.0.211-linux.run /tmp/
#ADD cyclone-16.0.0.211.qdz /tmp/

RUN cd /tmp/ && curl https://download.altera.com/akdlm/software/acdsinst/20.1std.1/720/ib_installers/QuartusLiteSetup-20.1.1.720-linux.run > QuartusLiteSetup-20.1.1.720-linux.run \
&& curl https://download.altera.com/akdlm/software/acdsinst/20.1std.1/720/ib_installers/ModelSimSetup-20.1.1.720-linux.run > ModelSimSetup-20.1.1.720-linux.run \
&& curl https://download.altera.com/akdlm/software/acdsinst/20.1std.1/720/ib_installers/cyclone-20.1.1.720.qdz > cyclone-20.1.1.720.qdz \
# Add execution permission
&& chmod +x *.run && chmod +r * \
# Install dependencies and tools
&& yum -y install tcsh libpng12 which Xvfb libXext libXrender libSM \
                   glibc.i686 glibc-devel.i686 zlib-devel.i686 \
                   libXft.i686 libXext.i686 ncurses-libs.i686 \
# Install Quartus+ModelSim in /opt
&& ./QuartusLiteSetup-20.1.1.720-linux.run --mode unattended --installdir /opt/intelfpga --accept_eula 1 \
# Clean the tmp folder
&& rm  /tmp/QuartusLiteSetup-20.1.1.720-linux.run /tmp/ModelSimSetup-20.1.1.720-linux.run /tmp/cyclone-20.1.1.720.qdz \
&& chmod -R 755 /opt/intelfpga

# Add to PATH
ENV PATH $PATH:/opt/intelfpga/quartus/bin:/opt/intelfpga/modelsim_ase/bin

# Enable talkback feature
#RUN xvfb-run -a tb2_install --enable
