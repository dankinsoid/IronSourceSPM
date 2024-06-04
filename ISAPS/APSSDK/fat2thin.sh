# this script does framework thinning
# it creates fat_framework folder to hold all originally "fat" frameworks
# During the build fat framework will be thin to hold only required architectures
# 
#  !!! The script should be located at the top of Build Phases sequence !!!
#

if [ ! -d $PROJECT_DIR/fat_frameworks ] 
then
# create storage directory for fat frameworks
    mkdir $PROJECT_DIR/fat_frameworks
fi

# include into the "files" array any framework you want to thin
files=( "DTBiOSSDK" "APSAdMobAdapter")
for file in "${files[@]}"
do
    directory=$(find $PROJECT_DIR -name "$file.framework")
  
    if [ ! -z "$directory" ]
    then
# execute only if $framework exists
        info=$(lipo -info $directory/$file)
        echo $info | grep -q "Architectures in the fat file"
#returned status should be 0 if there is a match
        if [ $?==0 ]
            then
#    output of lipo follows qualifies a file as a fat framework
            if [`echo $info|sed "s/^.*$file are://"|wc -w` -gt 1 ]
            then
#    copy multi architecture framework to a storage place if it does not exist
                if [ ! -f ${PROJECT_DIR}/fat_frameworks/${file} ]
                then 
                cp  $directory/$file $PROJECT_DIR/fat_frameworks
                fi
           fi
            
           archs=($ARCHS)
           
# extract thin architecture and place it into expected framework location
            
            length=${#archs[@]}
           
            if [ ${length} -eq 1 ]
            then
                lipo -extract $ARCHS $PROJECT_DIR/fat_frameworks/$file -o $directory/$file
            else
                create="lipo -create"
                if [ ! -d $PROJECT_DIR/temp ] 
                then
                # create temporary directory for individual architectures
                    mkdir $PROJECT_DIR/temp
                fi
                k=0
                for arch in $ARCHS
                do
                    tmpFile=$PROJECT_DIR/temp/$file$k
                 
                    lipo -extract $arch $PROJECT_DIR/fat_frameworks/$file -o $tmpFile
                    create="${create} ${tmpFile}"
                    k=`expr $k + 1`
                done
#Complete "create" command              
                create="${create} -o ${directory}/${file}"
#create archive with all required architectures               
                `$create`

#remove temporary directory
                `rm -rf $PROJECT_DIR/temp`
                
            fi
            
        fi
    fi
done

