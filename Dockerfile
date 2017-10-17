FROM ingi/inginious-c-base
LABEL org.inginious.grading.name="quartus"

# Copy Quartus+ModelSim install files
#ADD QuartusLiteSetup-16.0.0.211-linux.run /tmp/
#ADD ModelSimSetup-16.0.0.211-linux.run /tmp/
#ADD cyclone-16.0.0.211.qdz /tmp/

ADD vsim /tmp/

RUN cd /tmp/ && curl http://download.altera.com/akdlm/software/acdsinst/17.0std/595/ib_installers/QuartusLiteSetup-17.0.0.595-linux.run > QuartusLiteSetup-17.0.0.595-linux.run \
&& curl http://download.altera.com/akdlm/software/acdsinst/17.0std/595/ib_installers/ModelSimSetup-17.0.0.595-linux.run > ModelSimSetup-17.0.0.595-linux.run \
&& curl http://download.altera.com/akdlm/software/acdsinst/17.0std/595/ib_installers/cyclone-17.0.0.595.qdz > cyclone-17.0.0.595.qdz \
# Add execution permission
&& chmod +x *.run && chmod +r * \
# Install dependencies and tools
&& yum -y install tcsh libpng12 which Xvfb libXext libXrender libSM \
                   glibc.i686 glibc-devel.i686 zlib-devel.i686 \
                   libXft.i686 libXext.i686 ncurses-libs.i686 \
# Install Quartus+ModelSim in /opt
&& ./QuartusLiteSetup-17.0.0.595-linux.run --mode unattended --installdir /opt/intelfpga \
# Fix in vsim script
&& cp /opt/intelfpga/modelsim_ase/bin/vsim /opt/intelfpga/modelsim_ase/bin/vsim.bak && chown root:root vsim && cp vsim /opt/intelfpga/modelsim_ase/bin/vsim \
# Clean the tmp folder
&& rm -rf /tmp/*

# Add to PATH
ENV PATH $PATH:/opt/intelfpga/quartus/bin:/opt/intelfpga/modelsim_ase/bin

# Enable talkback feature
#RUN xvfb-run -a tb2_install --enable

