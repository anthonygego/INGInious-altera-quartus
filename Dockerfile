FROM ingi/inginious-c-default

# Copy Quartus+ModelSim install files
#ADD QuartusLiteSetup-16.0.0.211-linux.run /tmp/
#ADD ModelSimSetup-16.0.0.211-linux.run /tmp/
#ADD cyclone-16.0.0.211.qdz /tmp/

ADD http://download.altera.com/akdlm/software/acdsinst/16.0/211/ib_installers/QuartusLiteSetup-16.0.0.211-linux.run /tmp/
ADD http://download.altera.com/akdlm/software/acdsinst/16.0/211/ib_installers/ModelSimSetup-16.0.0.211-linux.run /tmp/
ADD http://download.altera.com/akdlm/software/acdsinst/16.0/211/ib_installers/cyclone-16.0.0.211.qdz /tmp/
ADD vsim /tmp/

# Add execution permission
RUN cd /tmp && chmod +x *.run && chmod +r *

# Install dependencies and tools
RUN yum -y install tcsh libpng12 which Xvfb libXext libXrender libSM \
                   glibc.i686 glibc-devel.i686 zlib-devel.i686 \
                   libXft.i686 libXext.i686 ncurses-libs.i686

# Install Quartus+ModelSim in /opt
RUN cd /tmp && ./QuartusLiteSetup-16.0.0.211-linux.run --mode unattended --installdir /opt/altera

# Fix in vsim script
RUN cd /tmp && chown root:root vsim && cp vsim /opt/altera/modelsim_ase/bin/vsim

# Add to PATH
ENV PATH $PATH:/opt/altera/quartus/bin:/opt/altera/modelsim_ase/bin

# Enable talkback feature
RUN xvfb-run -a tb2_install --enable

# Clean the /tmp folder
RUN rm -rf /tmp/*

