package com.examhub.utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class ReadWebPageEx {
	static ArrayList<List> listOfJobs = new ArrayList<>();

	public static ArrayList<List>  getJobPost() throws IOException {

		if(listOfJobs.size()==0) {

			URL url = new URL("http://www.smarthunt4u.com/");
			String data = "";
			try (BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()))) {
				int i = 0;
				String line;

				StringBuilder sb = new StringBuilder();

				while ((line = br.readLine()) != null && i != 5000) {

					sb.append(line);
					sb.append(System.lineSeparator());
					i++;
				}

				data = sb.substring(sb.indexOf("<h2>Most recent job offers</h2>")).replace('"', '\'');
			}
			int start1 = 0, end1 = data.length(), i = 0;

			while (i <= 250) {
				ArrayList<String> job = new ArrayList<>();

				int indexOfAlt = data.indexOf("alt='") + 5;
				String data1 = (data.substring(indexOfAlt).split("'"))[0];
				// System.out.println(data1);
				job.add(data1);

				int indexOfhref = data.indexOf("href='") + 6;
				String link = (data.substring(indexOfhref).split("'"))[0];

				// System.out.println(link);
				job.add(link);

				int indexOftitle = data.indexOf("title='") + 7;
				String title = (data.substring(indexOftitle).split("'"))[0];

				int indexOfspan = data.indexOf("<span class='la'>");
				String data2 = (data.substring(indexOfspan, data.indexOf("<span class='time-posted'>")));
				data2 = data2.replace("<span class='la'>", " ");
				data2 = data2.replace("</span>", " ");
				data2 = data2.replace("<span class='spotlight-image'>", " ");
				// System.out.println(title+" "+data2);

				job.add(title + " " + data2);
				
				int indexOfAlt2 = data.indexOf("alt='' />") + 9;
				String date = (data.substring(indexOfAlt2).split("<"))[0];
				// System.out.println(data1);
				job.add(date);

				listOfJobs.add(job);
				
				data = data.substring(indexOfAlt2);
				i++;
			}
		

		}
		return listOfJobs;
	}
}
/*
<a href='http://smarthunt4u.com/job/16816/t_033bb0520check-only-if-sms-received-else-you-will-black-listed-at-confidential/'
 title='T_033BB0520(Check only if SMS received else you will BLACK LISTED)'>T_033BB0520(Check only if SMS received else you will BLACK LISTED)</a> 
 <span class='la'>at</span> Confidential <span class='la'>in</span> Mumbai			</span>
			<span class='time-posted'>
			<img src='http://smarthunt4u.com/_templates/default/img/clock.gif'
			 alt='' /> 18-05-2020</span>

*/