#!/bin/bash

# Define the base URL for the audio files
BASE_URL="https://mobile.diyanet.gov.tr/sesdosyalari"

# Define the verse range for each surah
declare -A VERSE_RANGES=(
  ["1"]="7"
  ["2"]="286"
  ["3"]="200"
  ["4"]="176"
  ["5"]="120"
  ["6"]="165"
  ["7"]="206"
  ["8"]="75"
  ["9"]="129"
  ["10"]="109"
  ["11"]="123"
  ["12"]="111"
  ["13"]="43"
  ["14"]="52"
  ["15"]="99"
  ["16"]="128"
  ["17"]="111"
  ["18"]="110"
  ["19"]="98"
  ["20"]="135"
  ["21"]="112"
  ["22"]="78"
  ["23"]="118"
  ["24"]="64"
  ["25"]="77"
  ["26"]="227"
  ["27"]="93"
  ["28"]="88"
  ["29"]="69"
  ["30"]="60"
  ["31"]="34"
  ["32"]="30"
  ["33"]="73"
  ["34"]="54"
  ["35"]="45"
  ["36"]="83"
  ["37"]="182"
  ["38"]="88"
  ["39"]="75"
  ["40"]="85"
  ["41"]="54"
  ["42"]="53"
  ["43"]="89"
  ["44"]="59"
  ["45"]="37"
  ["46"]="35"
  ["47"]="38"
  ["48"]="29"
  ["49"]="18"
  ["50"]="45"
  ["51"]="60"
  ["52"]="49"
  ["53"]="62"
  ["54"]="55"
  ["55"]="78"
  ["56"]="96"
  ["57"]="29"
  ["58"]="22"
  ["59"]="24"
  ["60"]="13"
  ["61"]="14"
  ["62"]="11"
  ["63"]="11"
  ["64"]="18"
  ["65"]="12"
  ["66"]="12"
  ["67"]="30"
  ["68"]="52"
  ["69"]="52"
  ["70"]="44"
  ["71"]="28"
  ["72"]="28"
  ["73"]="20"
  ["74"]="56"
  ["75"]="40"
  ["76"]="31"
  ["77"]="50"
  ["78"]="40"
  ["79"]="46"
  ["80"]="42"
  ["81"]="29"
  ["82"]="19"
  ["83"]="36"
  ["84"]="25"
  ["85"]="22"
  ["86"]="17"
  ["87"]="19"
  ["88"]="26"
  ["89"]="30"
  ["90"]="20"
  ["91"]="15"
  ["92"]="21"
  ["93"]="11"
  ["94"]="8"
  ["95"]="8"
  ["96"]="19"
  ["97"]="5"
  ["98"]="8"
  ["99"]="8"
  ["100"]="11"
  ["101"]="11"
  ["102"]="8"
  ["103"]="3"
  ["104"]="9"
  ["105"]="5"
  ["106"]="4"
  ["107"]="7"
  ["108"]="3"
  ["109"]="6"
  ["110"]="3"
  ["111"]="5"
  ["112"]="4"
  ["113"]="5"
  ["114"]="6"
)

declare -A SURAH_VERSE_RANGES=(
  ["1"]="Fâtiha"
  ["2"]="Bakara"
  ["3"]="Âl-i_İmrân"
  ["4"]="Nisâ"
  ["5"]="Mâide"
  ["6"]="En'âm"
  ["7"]="A'râf"
  ["8"]="Enfâl"
  ["9"]="Tevbe"
  ["10"]="Yunus"
  ["11"]="Hûd"
  ["12"]="Yusuf"
  ["13"]="Ra'd"
  ["14"]="İbrahim"
  ["15"]="Hicr"
  ["16"]="Nahl"
  ["17"]="İsrâ"
  ["18"]="Kehf"
  ["19"]="Meryem"
  ["20"]="Tâ-Hâ"
  ["21"]="Enbiyâ"
  ["22"]="Hac"
  ["23"]="Mü'minûn"
  ["24"]="Nûr"
  ["25"]="Furkan"
  ["26"]="Şuarâ"
  ["27"]="Neml"
  ["28"]="Kasas"
  ["29"]="Ankebût"
  ["30"]="Rûm"
  ["31"]="Lokman"
  ["32"]="Secde"
  ["33"]="Ahzâb"
  ["34"]="Sebe'"
  ["35"]="Fâtır"
  ["36"]="Yâsin"
  ["37"]="Sâffât"
  ["38"]="Sâd"
  ["39"]="Zümer"
  ["40"]="Mü'min"
  ["41"]="Fussilet"
  ["42"]="Şûrâ"
  ["43"]="Zuhruf"
  ["44"]="Duhân"
  ["45"]="Câsiye"
  ["46"]="Ahkaf"
  ["47"]="Muhammed"
  ["48"]="Fetih"
  ["49"]="Hucurât"
  ["50"]="Kaf"
  ["51"]="Zâriyât"
  ["52"]="Tûr"
  ["53"]="Necm"
  ["54"]="Kamer"
  ["55"]="Rahmân"
  ["56"]="Vâkıa"
  ["57"]="Hadid"
  ["58"]="Mücâdele"
  ["59"]="Haşr"
  ["60"]="Mümtehine"
  ["61"]="Saf"
  ["62"]="Cum'a"
  ["63"]="Münâfikûn"
  ["64"]="Teğabün"
  ["65"]="Talâk"
  ["66"]="Tahrim"
  ["67"]="Mülk"
  ["68"]="Kalem"
  ["69"]="Hâkka"
  ["70"]="Meâric"
  ["71"]="Nuh"
  ["72"]="Cin"
  ["73"]="Müzzemmil"
  ["74"]="Müddessir"
  ["75"]="Kıyamet"
  ["76"]="İnsan"
  ["77"]="Mürselât"
  ["78"]="Nebe'"
  ["79"]="Nâziât"
  ["80"]="Abese"
  ["81"]="Tekvir"
  ["82"]="İnfitâr"
  ["83"]="Mutaffifin"
  ["84"]="İnşikak"
  ["85"]="Bürûc"
  ["86"]="Târık"
  ["87"]="A'lâ"
  ["88"]="Gâşiye"
  ["89"]="Fecr"
  ["90"]="Beled"
  ["91"]="Şems"
  ["92"]="Leyl"
  ["93"]="Duhâ"
  ["94"]="İnşirâh"
  ["95"]="Tin"
  ["96"]="Alak"
  ["97"]="Kadir"
  ["98"]="Beyyine"
  ["99"]="Zilzâl"
  ["100"]="Âdiyât"
  ["101"]="Kâria"
  ["102"]="Tekâsür"
  ["103"]="Asr"
  ["104"]="Hümeze"
  ["105"]="Fil"
  ["106"]="Kureyş"
  ["107"]="Mâûn"
  ["108"]="Kevser"
  ["109"]="Kâfirûn"
  ["110"]="Nasr"
  ["111"]="Tebbet"
  ["112"]="İhlâs"
  ["113"]="Felâk"
  ["114"]="Nâs"
)

# Ask the user to select a reciter
echo -e "\e[1m\e[93mHANGİ HAFIZI SEÇMEK İSTERSİNİZ?\e[0m"
echo "1. Davut Kaya | Try Listening https://mobile.diyanet.gov.tr/sesdosyalari/dk/dk2_282.mp3"
echo "2. İshak Danış | Try Listening https://mobile.diyanet.gov.tr/sesdosyalari/id/id2_282.mp3"
echo "3. Tayyar Altıkulaç | Try Listening https://mobile.diyanet.gov.tr/sesdosyalari/ta/ta2_282.mp3"
echo "4. Yaşar Cuhadar | Try Listening https://mobile.diyanet.gov.tr/sesdosyalari/yc/yc2_282.mp3"
echo "5. Fatih Okumuş | Try Listening https://mobile.diyanet.gov.tr/sesdosyalari/fo/fo2_282.mp3"
read -p "Lütfen bir sayı seçin: " reciter

# Set the selected reciter in the $hafiz variable
case $reciter in
  1)
    hafiz="dk"
    hafiz_full_name="Davut_Kaya"
    ;;
  2)
    hafiz="id"
    hafiz_full_name="İshak_Danış"
    ;;
  3)
    hafiz="ta"
    hafiz_full_name="Tayyar_Altıkulaç"
    ;;
  4)
    hafiz="yc"
    hafiz_full_name="Yaşar_Cuhadar"
    ;;
  5)
    hafiz="fo"
    hafiz_full_name="Fatih_Okumuş"
    ;;
  *)
    echo -e "\e[1m\e[91mHATALI SEÇİM YAPTINIZ. LÜTFEN TEKRAR DENEYİN.\e[0m"
    exit 1
    ;;
esac

# Record the start time
start_time=$(date +%s)

# Initialize total size to 0
total_size=0

# Loop through each surah and download the audio files for the specified verse range
for (( surah=1; surah<=114; surah++ )); do
  verse_count="${VERSE_RANGES[$surah]}"
  for (( ayah=1; ayah<=$verse_count; ayah++ )); do
    url_meal="${BASE_URL}/meal/m${surah}_${ayah}.mp3"
    url_arabic="${BASE_URL}/$hafiz/$hafiz${surah}_${ayah}.mp3"
    file_meal="${surah}_${ayah}_Meal_$(sed 's/[^a-zA-Z0-9]/_/g' <<< "${SURAH_VERSE_RANGES[$surah]}")_$hafiz_full_name.mp3"
    file_arabic="${surah}_${ayah}_Arapça_$(sed 's/[^a-zA-Z0-9]/_/g' <<< "${SURAH_VERSE_RANGES[$surah]}")_$hafiz_full_name.mp3"
    if [ -f "$file_meal" ] || [ -f "$file_arabic" ]; then
      echo "Dosya zaten var: $file_meal veya $file_arabic"
    else
      echo -e "\e[1m\e[92mDownloading audio files for Surah \e[42m\e[97m${surah}.${SURAH_VERSE_RANGES[$surah]} Surah\e[0m \e[41m\e[97mAyah ${ayah}\e[0m \e[48;5;208m\e[97mHafiz ${hafiz_full_name^}\e[0m"
      wget -q --show-progress --progress=bar -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Safari/605.1.15" "$url_meal" -O "$file_meal"
      wget -q --show-progress --progress=bar -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Safari/605.1.15" "$url_arabic" -O "$file_arabic"

      # Add the size of the downloaded files to the total size
      size_meal=$(stat --printf="%s" "$file_meal")
      size_arabic=$(stat --printf="%s" "$file_arabic")
      total_size=$((total_size + size_meal + size_arabic))
    fi

    # Check if the audio files are downloaded correctly
    if [ ! -s "$file_meal" ] || [ ! -s "$file_arabic" ]; then
      echo -e "\e[1m\e[93mError: Failed to download audio files for Surah ${surah}.${SURAH_VERSE_RANGES[$surah]} Surah, Ayah ${ayah}, Hafız ${hafiz_full_name^}. Re-downloading the files...\e[0m"
      rm -f "$file_meal" "$file_arabic"
      wget -q --show-progress --progress=bar -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Safari/605.1.15" "$url_meal" -O "$file_meal"
      wget -q --show-progress --progress=bar -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Safari/605.1.15" "$url_arabic" -O "$file_arabic"

      # Add the size of the downloaded files to the total size
      size_meal=$(stat --printf="%s" "$file_meal")
      size_arabic=$(stat --printf="%s" "$file_arabic")
      total_size=$((total_size + size_meal + size_arabic))
    fi
  done
done

# Record the end time
end_time=$(date +%s)

# Calculate the time taken in minutes
time_taken=$(( (end_time - start_time) / 60 ))

# Convert total size to MB
total_size_mb=$(echo "scale=2; $total_size/1024/1024" | bc)

# Print the total size of all downloads and time taken in minutes
echo -e "\e[1m\e[92mALL FILES DOWNLOADED SUCCESSFULLY. Total size: $total_size_mb MB. Time taken: $time_taken minutes.\e[0m"